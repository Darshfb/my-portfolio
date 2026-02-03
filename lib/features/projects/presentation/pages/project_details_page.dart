import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:myprofile/core/theme/app_colors.dart';
import 'package:myprofile/core/widgets/premium_widgets.dart';
import 'package:myprofile/features/projects/domain/entities/project.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
// import 'package:url_launcher/url_launcher.dart'; // Ensure this dependency is added if using launchUrl

class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Mostafa | ${project.title}',
      color: AppColors.gold,
      child: Scaffold(
        backgroundColor: AppColors.bgDark,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 500, // Taller header
              pinned: true,
              backgroundColor: AppColors.bgDark,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  project.title, 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,  shadows: [Shadow(color: Colors.black, blurRadius: 10)])
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'project-image-${project.id}', // Hero tag for smooth transition
                      child: CachedNetworkImage(
                        imageUrl: project.coverImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(color: AppColors.bgDark, child: const Center(child: CircularProgressIndicator(color: AppColors.gold, strokeWidth: 2))),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            AppColors.bgDark.withOpacity(0.5),
                            AppColors.bgDark,
                          ],
                          stops: const [0.0, 0.6, 0.85, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.gold),
                    onPressed: () => context.pop(),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(32),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    children: [
                      const Icon(Icons.workspace_premium, color: AppColors.gold, size: 20),
                      const SizedBox(width: 8),
                      Text(project.role, style: const TextStyle(color: AppColors.gold, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                    ],
                  ).animate().fadeIn(duration: 400.ms).slideX(),
  
                  const SizedBox(height: 8),
                  Text(
                    '${DateFormat('MMM yyyy').format(project.startDate)} - ${project.endDate != null ? DateFormat('MMM yyyy').format(project.endDate!) : "projects.present".tr()}',
                    style: TextStyle(color: AppColors.textDim.withOpacity(0.8), fontSize: 16),
                  ).animate().fadeIn(delay: 100.ms).slideX(),
                  
                  const SizedBox(height: 16),
                  if (project.subtitle != null) ...[
                    Text(project.subtitle!, style: const TextStyle(color: Colors.white, fontSize: 24, fontStyle: FontStyle.italic, fontWeight: FontWeight.w300)),
                    const SizedBox(height: 32),
                  ],
                  
                  // Tech Stack
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: project.technologies.map((t) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                      ),
                      child: Text(t, style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w500)),
                    )).toList(),
                  ).animate().fadeIn(delay: 200.ms).slideY(),
                  const SizedBox(height: 48),
                  
                  // Description
                  Text('projects.overview'.tr(), style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontSize: 28)),
                  const SizedBox(height: 24),
                  Text(
                    project.description,
                    style: const TextStyle(color: AppColors.textPremium, height: 1.8, fontSize: 18),
                  ).animate().fadeIn(delay: 300.ms),
                  
                  const SizedBox(height: 48),

                  // STAR Narrative
                  if (project.starNarrative != null) ...[
                    Text('projects.story'.tr(), style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontSize: 28)),
                    const SizedBox(height: 24),
                    _buildStarSection('projects.situation'.tr(), project.starNarrative!.situation, Icons.info_outline),
                    _buildStarSection('projects.task'.tr(), project.starNarrative!.task, Icons.assignment_outlined),
                    _buildStarSection('projects.action'.tr(), project.starNarrative!.action, Icons.play_circle_outline),
                    _buildStarSection('projects.result'.tr(), project.starNarrative!.result, Icons.check_circle_outline, isResult: true),
                    const SizedBox(height: 48),
                  ],

                  // Metrics
                  if (project.qaMetrics != null && project.qaMetrics!.isNotEmpty) ...[
                    Text('projects.metrics'.tr(), style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontSize: 28)),
                    const SizedBox(height: 24),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: project.qaMetrics!.length,
                      itemBuilder: (context, index) {
                        final entry = project.qaMetrics!.entries.elementAt(index);
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.gold.withOpacity(0.2)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(entry.key, style: TextStyle(color: AppColors.textDim.withOpacity(0.7), fontSize: 14)),
                              const SizedBox(height: 4),
                              Text(entry.value.toString(), style: const TextStyle(color: AppColors.gold, fontSize: 22, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ).animate().fadeIn(delay: (400 + index * 50).ms).scale();
                      },
                    ),
                    const SizedBox(height: 48),
                  ],
                  
                  // Gallery
                  if (project.galleryImages.isNotEmpty) ...[
                    Text('projects.visuals'.tr(), style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontSize: 28)),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 400, // Taller gallery
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: project.galleryImages.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 32),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withOpacity(0.1), width: 8), // Frame effect
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: project.galleryImages[index],
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(color: AppColors.bgDark, width: 250),
                                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                              ),
                            ),
                          ).animate().fadeIn(delay: (400 + index * 100).ms).slideX(begin: 0.2);
                        },
                      ),
                    ),
                    const SizedBox(height: 48),
                  ],

                  // Testimonial
                  if (project.testimonial != null) ...[
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.gold.withOpacity(0.1)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.format_quote_rounded, color: AppColors.gold, size: 48),
                          const SizedBox(height: 16),
                          Text(
                            project.testimonial!.quote,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic, height: 1.6),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            project.testimonial!.author,
                            style: const TextStyle(color: AppColors.gold, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          if (project.testimonial!.authorRole != null)
                            Text(
                              project.testimonial!.authorRole!,
                              style: TextStyle(color: AppColors.textDim.withOpacity(0.7), fontSize: 14),
                            ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 500.ms).scale(begin: const Offset(0.9, 0.9)),
                    const SizedBox(height: 48),
                  ],
                  
                  // Links
                  if (project.links.isNotEmpty) ...[
                    Text('projects.links'.tr(), style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontSize: 28)),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: project.links.entries.map((e) {
                        return PremiumButton(
                          text: e.key.toUpperCase(),
                          onPressed: () {
                            // launchUrl(Uri.parse(e.value)); 
                          },
                        );
                      }).toList(),
                    ).animate().fadeIn(delay: 600.ms),
                  ],
                  const SizedBox(height: 80),
                  const PortfolioFooter(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildStarSection(String label, String content, IconData icon, {bool isResult = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isResult ? AppColors.gold.withOpacity(0.05) : Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isResult ? AppColors.gold.withOpacity(0.3) : Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: isResult ? AppColors.gold : AppColors.textDim, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label.toUpperCase(), style: TextStyle(color: isResult ? AppColors.gold : AppColors.textDim, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2)),
                const SizedBox(height: 8),
                Text(content, style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.1);
  }
}
