import 'package:flutter/material.dart';
import 'package:myprofile/features/projects/domain/entities/project.dart';
import '../../../../core/widgets/premium_widgets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/image_upload_service.dart';
import '../../../../core/di/injection.dart';
import 'package:cached_network_image/cached_network_image.dart';

const List<String> _kPredefinedRoles = [
  'Senior Flutter Developer',
  'Middle Flutter Developer',
  'Junior Flutter Developer',
  'Senior QA Engineer',
  'QA Automation Engineer',
  'Software QA Engineer',
  'Mobile Application Developer',
  'Full Stack Developer',
];

class AddEditProjectDialog extends StatefulWidget {
  final Project? project;

  const AddEditProjectDialog({super.key, this.project});

  @override
  State<AddEditProjectDialog> createState() => _AddEditProjectDialogState();
}

class _AddEditProjectDialogState extends State<AddEditProjectDialog> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  late TextEditingController _descController;
  late TextEditingController _roleController;
  late TextEditingController _techController;
  late TextEditingController _mainUrlController;
  
  // QA Specific
  late TextEditingController _testingTypesController;
  
  // Pro-Level Storytelling (STAR)
  late TextEditingController _situationController;
  late TextEditingController _taskController;
  late TextEditingController _actionController;
  late TextEditingController _resultController;
  
  // Testimonial
  late TextEditingController _quoteController;
  late TextEditingController _authorController;
  late TextEditingController _authorRoleController;
  
  // Metrics
  late Map<String, dynamic> _qaMetrics;
  
  ProjectType _selectedType = ProjectType.flutter;
  String? _coverImageUrl;
  List<String> _galleryImages = [];
  Map<String, String> _links = {};
  int _orderIndex = 0;
  bool _isPublished = true;
  
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;
  
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    final p = widget.project;
    _titleController = TextEditingController(text: p?.title);
    _subtitleController = TextEditingController(text: p?.subtitle);
    _descController = TextEditingController(text: p?.description);
    _roleController = TextEditingController(text: p?.role);
    _techController = TextEditingController(text: p?.technologies.join(', '));
    _mainUrlController = TextEditingController(text: p?.mainUrl);
    _testingTypesController = TextEditingController(text: p?.testingTypes.join(', '));
    
    // STAR
    _situationController = TextEditingController(text: p?.starNarrative?.situation);
    _taskController = TextEditingController(text: p?.starNarrative?.task);
    _actionController = TextEditingController(text: p?.starNarrative?.action);
    _resultController = TextEditingController(text: p?.starNarrative?.result);
    
    // Testimonial
    _quoteController = TextEditingController(text: p?.testimonial?.quote);
    _authorController = TextEditingController(text: p?.testimonial?.author);
    _authorRoleController = TextEditingController(text: p?.testimonial?.authorRole);
    
    _qaMetrics = p?.qaMetrics != null ? Map<String, dynamic>.from(p!.qaMetrics!) : {};
    
    if (p != null) {
      _selectedType = p.type;
      _coverImageUrl = p.coverImage;
      _galleryImages = List.from(p.galleryImages);
      _links = Map.from(p.links);
      _orderIndex = p.orderIndex;
      _isPublished = p.isPublished;
      _startDate = p.startDate;
      _endDate = p.endDate;
    }
  }

  Future<void> _pickCoverImage() async {
    setState(() => _isUploading = true);
    final url = await getIt<ImageUploadService>().uploadProjectImage();
    setState(() {
      if (url != null) _coverImageUrl = url;
      _isUploading = false;
    });
  }

  Future<void> _pickGalleryImage() async {
    setState(() => _isUploading = true);
    final url = await getIt<ImageUploadService>().uploadProjectImage();
    setState(() {
      if (url != null) _galleryImages.add(url);
      _isUploading = false;
    });
  }

  void _addLink() {
    String label = '';
    String url = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.bgDark,
        title: const Text('Add Link', style: TextStyle(color: AppColors.gold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Label (e.g. GitHub)'),
              style: const TextStyle(color: Colors.white),
              onChanged: (v) => label = v,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'URL'),
              style: const TextStyle(color: Colors.white),
              onChanged: (v) => url = v,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
          TextButton(
            onPressed: () {
              if (label.isNotEmpty && url.isNotEmpty) {
                setState(() => _links[label] = url);
                Navigator.pop(context);
              }
            },
            child: const Text('ADD'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.bgDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.project == null ? 'Add Project' : 'Edit Project',
                    style: const TextStyle(color: AppColors.gold, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<ProjectType>(
                    value: _selectedType,
                    dropdownColor: AppColors.cardBg,
                    style: const TextStyle(color: AppColors.textPremium),
                    items: ProjectType.values.map((t) {
                      return DropdownMenuItem(value: t, child: Text(t.name.toUpperCase()));
                    }).toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _selectedType = v);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Core Info
                        Row(
                        children: [
                          Expanded(child: _buildField(_titleController, 'Title')),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Autocomplete<String>(
                              optionsBuilder: (v) => _kPredefinedRoles.where((e) => e.toLowerCase().contains(v.text.toLowerCase())),
                              initialValue: TextEditingValue(text: _roleController.text),
                              onSelected: (v) => _roleController.text = v,
                              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                                // Sync local controller if needed, but we use _roleController separately or bind it
                                // Better: Use _roleController as the controller here if possible, but Autocomplete manages its own.
                                // simpler: Just bind events.
                                if (controller.text != _roleController.text && _roleController.text.isNotEmpty && controller.text.isEmpty) {
                                  controller.text = _roleController.text;
                                }
                                return TextField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  style: const TextStyle(color: AppColors.textPremium),
                                  decoration: InputDecoration(
                                    labelText: 'Role',
                                    labelStyle: const TextStyle(color: AppColors.textDim),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textDim.withOpacity(0.3))),
                                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.gold)),
                                  ),
                                  onChanged: (v) => _roleController.text = v,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildField(_subtitleController, 'Subtitle'),
                      const SizedBox(height: 16),
                      _buildField(_descController, 'Description (Markdown)', maxLines: 5),
                      const SizedBox(height: 16),
                      
                      // Tech & QA
                      _buildField(_techController, 'Technologies (comma separated)'),
                      if (_selectedType != ProjectType.flutter) ...[
                        const SizedBox(height: 16),
                        _buildField(_testingTypesController, 'Testing Types (comma separated)'),
                      ],
                      const SizedBox(height: 16),
                      _buildField(_mainUrlController, 'Main URL'),
                      
                      const SizedBox(height: 32),
                      const Divider(color: AppColors.gold, thickness: 1),
                      const SizedBox(height: 16),
                      Text('Professional Narrative (STAR Method)', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.gold)),
                      const SizedBox(height: 16),
                      _buildField(_situationController, 'Situation', maxLines: 2),
                      const SizedBox(height: 12),
                      _buildField(_taskController, 'Task', maxLines: 2),
                      const SizedBox(height: 12),
                      _buildField(_actionController, 'Action', maxLines: 4),
                      const SizedBox(height: 12),
                      _buildField(_resultController, 'Result', maxLines: 3),
                      
                      const SizedBox(height: 32),
                      const Divider(color: AppColors.gold, thickness: 1),
                      const SizedBox(height: 16),
                      Text('Testimonial', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.gold)),
                      const SizedBox(height: 16),
                      _buildField(_quoteController, 'Quote', maxLines: 3),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: _buildField(_authorController, 'Author')),
                          const SizedBox(width: 12),
                          Expanded(child: _buildField(_authorRoleController, 'Role (e.g. CTO)')),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      const Divider(color: AppColors.gold, thickness: 1),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Metrics & Key Results', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.gold)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: AppColors.gold),
                            onPressed: () {
                              String key = '';
                              String val = '';
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: AppColors.bgDark,
                                  title: const Text('Add Metric', style: TextStyle(color: AppColors.gold)),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(decoration: const InputDecoration(labelText: 'Key (e.g. Pass Rate)'), style: const TextStyle(color: Colors.white), onChanged: (v) => key = v),
                                      TextField(decoration: const InputDecoration(labelText: 'Value (e.g. 98%)'), style: const TextStyle(color: Colors.white), onChanged: (v) => val = v),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('CANCEL')),
                                    TextButton(onPressed: () { if(key.isNotEmpty) { setState(() => _qaMetrics[key] = val); Navigator.pop(ctx); } }, child: const Text('ADD')),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      if (_qaMetrics.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: _qaMetrics.entries.map((e) => ListTile(
                              dense: true,
                              title: Text(e.key, style: const TextStyle(color: AppColors.gold)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(e.value.toString(), style: const TextStyle(color: Colors.white)),
                                  IconButton(icon: const Icon(Icons.close, size: 16, color: Colors.red), onPressed: () => setState(() => _qaMetrics.remove(e.key))),
                                ],
                              ),
                            )).toList(),
                          ),
                        ),
                      
                      const SizedBox(height: 24),
                      const Divider(color: AppColors.textDim),
                      const SizedBox(height: 16),
                      
                      // Cover Image
                      Text('Cover Image', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.gold)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          if (_coverImageUrl != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: CachedNetworkImage(
                                imageUrl: _coverImageUrl!,
                                width: 100,
                                height: 60,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(color: AppColors.bgDark, width: 100, height: 60),
                                errorWidget: (context, url, error) => Container(
                                  width: 100,
                                  height: 60,
                                  color: AppColors.bgDark,
                                  child: const Icon(Icons.broken_image, color: Colors.red),
                                ),
                              ),
                            ),
                          PremiumButton(
                            text: 'SELECT COVER',
                            isSecondary: true,
                            onPressed: _isUploading ? () {} : () { _pickCoverImage(); },
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Gallery
                      Text('Gallery', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.gold)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ..._galleryImages.map((url) => Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: url, 
                                width: 100, 
                                height: 60, 
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(color: AppColors.bgDark, width: 100, height: 60),
                                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: InkWell(
                                  onTap: () => setState(() => _galleryImages.remove(url)),
                                  child: const Icon(Icons.close, color: Colors.red, size: 20),
                                ),
                              ),
                            ],
                          )),
                          IconButton(
                            onPressed: _isUploading ? () {} : () { _pickGalleryImage(); },
                            icon: const Icon(Icons.add_photo_alternate, color: AppColors.gold),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Dynamic Links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Links', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.gold)),
                          IconButton(onPressed: _addLink, icon: const Icon(Icons.add, color: AppColors.gold)),
                        ],
                      ),
                      ..._links.entries.map((e) => ListTile(
                        title: Text(e.key, style: const TextStyle(color: Colors.white)),
                        subtitle: Text(e.value, style: const TextStyle(color: AppColors.textDim)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => setState(() => _links.remove(e.key)),
                        ),
                      )),

                      const SizedBox(height: 16),
                      // Order & Publish
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(labelText: 'Order Index', labelStyle: TextStyle(color: AppColors.textDim)),
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(text: _orderIndex.toString()),
                              onChanged: (v) => _orderIndex = int.tryParse(v) ?? 0,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Published', style: TextStyle(color: Colors.white)),
                              const SizedBox(width: 8),
                              Switch(
                                value: _isPublished,
                                onChanged: (v) => setState(() => _isPublished = v),
                                activeColor: AppColors.gold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCEL', style: TextStyle(color: AppColors.textDim)),
                  ),
                  const SizedBox(width: 16),
                  PremiumButton(
                    text: 'SAVE PROJECT',
                    onPressed: () {
                       if (_titleController.text.isEmpty || _coverImageUrl == null) {
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text('Title and Cover Image are required')),
                         );
                         return;
                       }
                       
                       final p = Project(
                         id: widget.project?.id ?? '',
                         title: _titleController.text,
                         subtitle: _subtitleController.text,
                         description: _descController.text,
                         role: _roleController.text,
                         type: _selectedType,
                         coverImage: _coverImageUrl!,
                         galleryImages: _galleryImages,
                         technologies: _techController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
                         testingTypes: _testingTypesController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
                         qaMetrics: _qaMetrics.isEmpty ? null : _qaMetrics,
                         starNarrative: _situationController.text.isEmpty ? null : StarNarrative(
                           situation: _situationController.text,
                           task: _taskController.text,
                           action: _actionController.text,
                           result: _resultController.text,
                         ),
                         testimonial: _quoteController.text.isEmpty ? null : Testimonial(
                           quote: _quoteController.text,
                           author: _authorController.text,
                           authorRole: _authorRoleController.text.isEmpty ? null : _authorRoleController.text,
                         ),
                         mainUrl: _mainUrlController.text,
                         links: _links,
                         orderIndex: _orderIndex,
                         isPublished: _isPublished,
                         createdAt: widget.project?.createdAt ?? DateTime.now(),
                         updatedAt: DateTime.now(),
                         startDate: _startDate,
                         endDate: _endDate,
                       );
                       Navigator.pop(context, p);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.textPremium),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textDim),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textDim.withOpacity(0.3))),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.gold)),
      ),
    );
  }
}
