import 'package:seo/seo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:myprofile/features/projects/domain/entities/project.dart';
import '../../../../core/widgets/premium_widgets.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/projects_cubit.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectsCubit>().fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Mostafa | My Projects',
      color: AppColors.gold,
      child: Seo.text(
        text: 'Explore my premium Flutter and QA projects, ranging from mobile applications to automated testing frameworks.',
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 80)), // For floating header
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'projects.title'.tr(),
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40),
                        ),
                        _buildSegmentedControl(context),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: BlocBuilder<ProjectsCubit, ProjectsState>(
                builder: (context, state) {
                  if (state is ProjectsLoading) {
                    return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(color: AppColors.gold)));
                  }
                  if (state is ProjectsError) {
                    return SliverToBoxAdapter(child: Center(child: Text(state.message, style: const TextStyle(color: Colors.red))));
                  }
                  if (state is ProjectsLoaded) {
                    final projects = state.filteredProjects;
                    if (projects.isEmpty) {
                      return SliverToBoxAdapter(child: Center(child: Text('projects.no_projects'.tr(), style: const TextStyle(color: AppColors.textDim))));
                    }
                    return SliverGrid(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400,
                        mainAxisSpacing: 24,
                        crossAxisSpacing: 24,
                        childAspectRatio: 0.85,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ProjectCard(project: projects[index])
                              .animate()
                              .fadeIn(duration: 600.ms, delay: (100 * index).ms)
                              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad);
                        },
                        childCount: projects.length,
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox());
                },
              ),
            ),
            const SliverToBoxAdapter(child: PortfolioFooter()),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedControl(BuildContext context) {
    return BlocBuilder<ProjectsCubit, ProjectsState>(
      builder: (context, state) {
        ProjectType? currentFilter;
        if (state is ProjectsLoaded) {
          currentFilter = state.filter;
        }

        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.textDim.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterTab(context, 'ALL', null, currentFilter),
              _buildFilterTab(context, 'FLUTTER', ProjectType.flutter, currentFilter),
              _buildFilterTab(context, 'QA', ProjectType.qa, currentFilter),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterTab(BuildContext context, String label, ProjectType? type, ProjectType? currentGroup) {
    final bool isSelected = type == currentGroup;
    return GestureDetector(
      onTap: () {
        context.read<ProjectsCubit>().setFilter(type);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gold : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.bgDark : AppColors.textDim,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
