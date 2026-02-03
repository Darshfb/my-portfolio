
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/social_link.dart';
import '../utils/social_icon_helper.dart';

class AddEditSocialLinkDialog extends StatefulWidget {
  final SocialLink? link;

  const AddEditSocialLinkDialog({super.key, this.link});

  @override
  State<AddEditSocialLinkDialog> createState() => _AddEditSocialLinkDialogState();
}

class _AddEditSocialLinkDialogState extends State<AddEditSocialLinkDialog> {
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();
  String _selectedIconKey = 'linkedin';

  @override
  void initState() {
    super.initState();
    if (widget.link != null) {
      _nameController.text = widget.link!.name;
      _urlController.text = widget.link!.url;
      _selectedIconKey = widget.link!.iconName.toLowerCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.bgDark,
      title: Text(
        widget.link == null ? 'admin.add_link'.tr() : '${'common.edit'.tr()} Social Link',
        style: const TextStyle(color: AppColors.gold),
      ),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_nameController, 'social.platform_name'.tr()),
              const SizedBox(height: 16),
              _buildTextField(_urlController, 'social.platform_url'.tr()),
              const SizedBox(height: 24),
              Text('social.select_icon'.tr(), style: const TextStyle(color: AppColors.textDim, fontSize: 14)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: SocialIconHelper.icons.keys.map((key) {
                  final isSelected = _selectedIconKey == key;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIconKey = key),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.gold.withOpacity(0.1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? AppColors.gold : Colors.white10,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        SocialIconHelper.getIcon(key),
                        color: isSelected ? AppColors.gold : AppColors.textDim,
                        size: 24,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('common.cancel'.tr())),
        TextButton(
          onPressed: () {
            final link = SocialLink(
              id: widget.link?.id ?? const Uuid().v4(),
              name: _nameController.text,
              url: _urlController.text,
              iconName: _selectedIconKey,
            );
            Navigator.pop(context, link);
          },
          child: Text(widget.link == null ? 'common.add'.tr() : 'common.save'.tr(), style: const TextStyle(color: AppColors.gold)),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textDim),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white10)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.gold)),
      ),
    );
  }
}
