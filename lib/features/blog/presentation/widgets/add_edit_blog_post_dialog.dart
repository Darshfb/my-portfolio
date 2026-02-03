import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/blog_post.dart';
import '../bloc/blog_bloc.dart';
import '../bloc/blog_event.dart';
import '../bloc/blog_state.dart';

class AddEditBlogPostDialog extends StatefulWidget {
  final BlogPost? post;

  const AddEditBlogPostDialog({super.key, this.post});

  @override
  State<AddEditBlogPostDialog> createState() => _AddEditBlogPostDialogState();
}

class _AddEditBlogPostDialogState extends State<AddEditBlogPostDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _summaryController;
  late TextEditingController _contentController;
  late TextEditingController _authorController;
  late TextEditingController _tagsController;
  String _selectedLanguage = 'English';
  
  String? _imageUrl;
  bool _isUploading = false;
  double _uploadProgress = 0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post?.title ?? '');
    _summaryController = TextEditingController(text: widget.post?.summary ?? '');
    _contentController = TextEditingController(text: widget.post?.content ?? '');
    _authorController = TextEditingController(text: widget.post?.author ?? 'Mostafa');
    _tagsController = TextEditingController(text: widget.post?.tags.join(', ') ?? 'FLUTTER');
    _imageUrl = widget.post?.imageUrl;
    _selectedLanguage = widget.post?.language ?? 'English';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _summaryController.dispose();
    _contentController.dispose();
    _authorController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _isUploading = true;
        _uploadProgress = 0;
      });

      try {
        final fileName = 'blog_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final ref = FirebaseStorage.instance.ref().child('blog_posts/$fileName');
        
        final uploadTask = ref.putData(
          result.files.single.bytes!,
          SettableMetadata(contentType: 'image/jpeg'),
        );

        uploadTask.snapshotEvents.listen((event) {
          setState(() {
            _uploadProgress = event.bytesTransferred / event.totalBytes;
          });
        });

        final snapshot = await uploadTask;
        final url = await snapshot.ref.getDownloadURL();

        setState(() {
          _imageUrl = url;
          _isUploading = false;
        });
      } catch (e) {
        setState(() => _isUploading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${'errors.upload_failed'.tr()}: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final post = BlogPost(
        id: widget.post?.id ?? '',
        title: _titleController.text.trim(),
        summary: _summaryController.text.trim(),
        content: _contentController.text.trim(),
        author: _authorController.text.trim(),
        publishDate: widget.post?.publishDate ?? DateTime.now(),
        imageUrl: _imageUrl,
        tags: _tagsController.text.split(',').map((t) => t.trim().toUpperCase()).toList(),
        likeCount: widget.post?.likeCount ?? 0,
        commentCount: widget.post?.commentCount ?? 0,
        language: _selectedLanguage,
      );

      if (widget.post == null) {
        context.read<BlogBloc>().add(CreateBlogPostEvent(post));
      } else {
        context.read<BlogBloc>().add(UpdateBlogPostEvent(post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.green),
          );
          // Safely pop the dialog after the current frame to avoid navigation assertion errors
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context, true);
            }
          });
        } else if (state is BlogError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Dialog(
        backgroundColor: AppColors.bgDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post == null ? 'admin.write_post'.tr().toUpperCase() : 'common.edit'.tr().toUpperCase() + ' POST',
                    style: const TextStyle(color: AppColors.gold, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
                  
                  // Image Picker
                  _buildImagePicker(),
                  const SizedBox(height: 24),
                  
                  _buildTextField(controller: _titleController, label: 'forms.title'.tr(), hint: 'forms.enter_title'.tr()),
                  const SizedBox(height: 16),
                  _buildTextField(controller: _summaryController, label: 'forms.summary'.tr(), hint: 'forms.enter_summary'.tr(), maxLines: 2),
                  const SizedBox(height: 16),
                  _buildTextField(controller: _contentController, label: 'forms.content'.tr() + ' (Markdown)', hint: 'forms.enter_content'.tr(), maxLines: 15),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildTextField(controller: _authorController, label: 'blog.author'.tr())),
                      const SizedBox(width: 16),
                      Expanded(child: _buildLanguageDropdown()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(controller: _tagsController, label: 'blog.tags'.tr() + ' (comma separated)'),
                  const SizedBox(height: 40),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('common.cancel'.tr(), style: const TextStyle(color: AppColors.textDim)),
                      ),
                      const SizedBox(width: 16),
                      BlocBuilder<BlogBloc, BlogState>(
                        builder: (context, state) {
                          final isLoading = state is BlogLoading || _isUploading;
                          return ElevatedButton(
                            onPressed: isLoading ? null : _save,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.gold,
                              foregroundColor: AppColors.primaryDark,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: isLoading
                                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryDark))
                                : Text('common.save'.tr() + ' POST', style: const TextStyle(fontWeight: FontWeight.bold)),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('blog.image'.tr().toUpperCase(), style: const TextStyle(color: AppColors.textDim, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _pickAndUploadImage,
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              image: _imageUrl != null ? DecorationImage(image: NetworkImage(_imageUrl!), fit: BoxFit.cover) : null,
            ),
            child: _imageUrl == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_photo_alternate_outlined, color: AppColors.gold, size: 40),
                      const SizedBox(height: 8),
                      Text('blog.upload_image'.tr(), style: TextStyle(color: Colors.white.withOpacity(0.4))),
                    ],
                  )
                : const SizedBox(),
          ),
        ),
        if (_isUploading) ...[
          const SizedBox(height: 12),
          LinearProgressIndicator(value: _uploadProgress, color: AppColors.gold, backgroundColor: Colors.white10),
        ],
      ],
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, String? hint, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: const TextStyle(color: AppColors.textDim, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.gold, width: 1)),
            contentPadding: const EdgeInsets.all(16),
          ),
          validator: (val) => val == null || val.isEmpty ? 'forms.required_field'.tr() : null,
        ),
      ],
    );
  }

  Widget _buildLanguageDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('blog.language'.tr().toUpperCase(), style: const TextStyle(color: AppColors.textDim, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedLanguage,
              dropdownColor: AppColors.bgDark,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              isExpanded: true,
              items: ['English', 'Arabic'].map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedLanguage = val);
              },
            ),
          ),
        ),
      ],
    );
  }
}
