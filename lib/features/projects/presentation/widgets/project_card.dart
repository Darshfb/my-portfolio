import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myprofile/features/projects/domain/entities/project.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/widgets/premium_widgets.dart';
import '../../../../core/theme/app_colors.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Determine badge color based on type
    final isFlutter = widget.project.type.name.toLowerCase().contains('flutter');
    final badgeColor = isFlutter ? const Color(0xFF42A5F5) : const Color(0xFF66BB6A); // Blue for Flutter, Green for QA
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Semantics(
        label: 'View details for project ${widget.project.title}',
        button: true,
        onTap: () => context.push('/projects/details', extra: widget.project),
        child: GestureDetector(
          onTap: () => context.push('/projects/details', extra: widget.project),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered ? AppColors.gold.withOpacity(0.6) : Colors.white.withOpacity(0.05),
                width: _isHovered ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered ? AppColors.gold.withOpacity(0.1) : Colors.black.withOpacity(0.2),
                  blurRadius: _isHovered ? 24 : 10,
                  offset: Offset(0, _isHovered ? 12 : 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                Expanded(
                  flex: 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.project.coverImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(color: AppColors.bgDark, child: const Center(child: CircularProgressIndicator(color: AppColors.gold, strokeWidth: 2))),
                        errorWidget: (context, url, error) => Container(color: AppColors.bgDark, child: const Icon(Icons.broken_image, color: AppColors.textDim)),
                      ),
                      // Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.bgDark.withOpacity(0.3),
                              AppColors.bgDark.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                      // Type Badge
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: badgeColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: badgeColor.withOpacity(0.5)),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isFlutter ? Icons.flutter_dash : Icons.bug_report,
                                size: 14,
                                color: badgeColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.project.type.name.toUpperCase(),
                                style: TextStyle(color: badgeColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Content Section
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.project.title,
                              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.workspace_premium, color: AppColors.gold, size: 14),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    widget.project.role,
                                    style: const TextStyle(color: AppColors.gold, fontSize: 13, fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${DateFormat('MMM yyyy').format(widget.project.startDate)} - ${widget.project.endDate != null ? DateFormat('MMM yyyy').format(widget.project.endDate!) : "Present"}',
                              style: TextStyle(color: AppColors.textDim.withOpacity(0.7), fontSize: 11),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Tech Stack Chips
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          clipBehavior: Clip.hardEdge,
                          children: widget.project.technologies.take(3).map((t) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white.withOpacity(0.1)),
                            ),
                            child: Text(
                              t,
                              style: const TextStyle(color: AppColors.textPremium, fontSize: 11),
                            ),
                          )).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
