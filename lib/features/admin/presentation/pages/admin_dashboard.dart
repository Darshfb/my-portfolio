import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;

import 'package:myprofile/core/theme/app_colors.dart';
import 'package:myprofile/core/widgets/premium_widgets.dart';
import 'package:myprofile/features/projects/domain/entities/project.dart';
import 'package:myprofile/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:myprofile/features/social_links/domain/entities/social_link.dart';
import 'package:myprofile/features/social_links/presentation/cubit/social_links_cubit.dart';
import 'package:myprofile/features/social_links/presentation/cubit/social_links_state.dart';
import 'package:myprofile/features/social_links/presentation/widgets/add_edit_social_link_dialog.dart';
import 'package:myprofile/features/social_links/presentation/utils/social_icon_helper.dart';
import '../widgets/add_edit_project_dialog.dart';
import 'package:myprofile/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:myprofile/features/blog/presentation/bloc/blog_event.dart';
import 'package:myprofile/features/blog/presentation/bloc/blog_state.dart';
import 'package:myprofile/features/blog/presentation/widgets/add_edit_blog_post_dialog.dart';
import 'package:myprofile/features/blog/domain/entities/blog_post.dart';

import 'package:file_picker/file_picker.dart';
import 'package:myprofile/features/resume/presentation/cubit/resume_cubit.dart';
import 'package:myprofile/features/resume/presentation/cubit/resume_state.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    context.read<ProjectsCubit>().fetchProjects();
    context.read<SocialLinksCubit>().fetchSocialLinks();
    context.read<ResumeCubit>().fetchResumeMetadata();
    context.read<BlogBloc>().add(const FetchBlogPosts());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _pickAndUploadCV() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.bytes != null && mounted) {
      context.read<ResumeCubit>().uploadCV(
        result.files.single.bytes!,
        'Mostafa_CV_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
    }
  }

  void _showAddEditProjectDialog([Project? project]) async {
    final result = await showDialog<Project>(
      context: context,
      builder: (context) => AddEditProjectDialog(project: project),
    );

    if (result != null && mounted) {
      if (project == null) {
        context.read<ProjectsCubit>().addProject(result);
      } else {
        context.read<ProjectsCubit>().updateProject(result);
      }
    }
  }

  void _showAddEditSocialDialog([SocialLink? link]) async {
    final result = await showDialog<SocialLink>(
      context: context,
      builder: (context) => AddEditSocialLinkDialog(link: link),
    );

    if (result != null && mounted) {
      if (link == null) {
        context.read<SocialLinksCubit>().addSocialLink(result);
      } else {
        context.read<SocialLinksCubit>().updateSocialLink(result);
      }
    }
  }

  void _confirmDeleteProject(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.bgDark,
        title: const Text(
          'Delete Project',
          style: TextStyle(color: AppColors.gold),
        ),
        content: const Text(
          'Are you sure you want to delete this project?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              context.read<ProjectsCubit>().deleteProject(id);
              Navigator.pop(context);
            },
            child: const Text('DELETE', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteSocial(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.bgDark,
        title: const Text(
          'Delete Link',
          style: TextStyle(color: AppColors.gold),
        ),
        content: const Text(
          'Are you sure you want to delete this social link?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              context.read<SocialLinksCubit>().deleteSocialLink(id);
              Navigator.pop(context);
            },
            child: const Text('DELETE', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showAddEditBlogDialog([BlogPost? post]) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AddEditBlogPostDialog(post: post),
    );

    if (result != null && mounted) {
      context.read<BlogBloc>().add(const FetchBlogPosts());
    }
  }

  void _confirmDeleteBlogPost(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.bgDark,
        title: const Text(
          'Delete Post',
          style: TextStyle(color: AppColors.gold),
        ),
        content: const Text(
          'Are you sure you want to delete this blog post?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              context.read<BlogBloc>().add(DeleteBlogPostEvent(id));
              Navigator.pop(context);
            },
            child: const Text('DELETE', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Mostafa | Admin Board',
      color: AppColors.gold,
      child: Padding(
        padding: const EdgeInsets.only(top: 80), // For floating header
        child: Scaffold(
          backgroundColor: AppColors.bgDark,
          appBar: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: AppColors.gold,
            unselectedLabelColor: AppColors.textDim,
            indicatorColor: AppColors.gold,
            tabs: const [
              Tab(text: 'PROJECTS', icon: Icon(Icons.work_outline)),
              Tab(text: 'SOCIAL LINKS', icon: Icon(Icons.share_outlined)),
              Tab(text: 'RESUME', icon: Icon(Icons.description_outlined)),
              Tab(text: 'BLOG', icon: Icon(Icons.article_outlined)),
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildProjectsTab(),
              _buildSocialLinksTab(),
              _buildResumeTab(),
              _buildBlogTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogTab() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Blog Management',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 28),
              ),
              PremiumButton(
                text: 'WRITE POST',
                onPressed: () => _showAddEditBlogDialog(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<BlogBloc, BlogState>(
              builder: (context, state) {
                if (state is BlogLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.gold),
                  );
                }
                if (state is BlogPostsLoaded) {
                  return ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      final post = state.posts[index];
                      return _buildManagementCard(
                        title: post.title,
                        subtitle: post.summary,
                        imageUrl: post.imageUrl,
                        onEdit: () => _showAddEditBlogDialog(post),
                        onDelete: () => _confirmDeleteBlogPost(post.id),
                      );
                    },
                  );
                }
                // If in single post state or other, restore the list
                if (state is! BlogLoading) {
                  context.read<BlogBloc>().add(const FetchBlogPosts());
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsTab() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Portfolio Projects',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 28),
              ),
              PremiumButton(
                text: 'ADD PROJECT',
                onPressed: () => _showAddEditProjectDialog(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<ProjectsCubit, ProjectsState>(
              builder: (context, state) {
                if (state is ProjectsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.gold),
                  );
                }
                if (state is ProjectsError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (state is ProjectsLoaded) {
                  return ListView.builder(
                    itemCount: state.projects.length,
                    itemBuilder: (context, index) {
                      final project = state.projects[index];
                      return _buildManagementCard(
                        title: project.title,
                        subtitle: project.description,
                        imageUrl: project.coverImage,
                        onEdit: () => _showAddEditProjectDialog(project),
                        onDelete: () => _confirmDeleteProject(project.id),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinksTab() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Social Connections',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 28),
              ),
              PremiumButton(
                text: 'ADD LINK',
                onPressed: () => _showAddEditSocialDialog(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<SocialLinksCubit, SocialLinksState>(
              builder: (context, state) {
                if (state is SocialLinksLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.gold),
                  );
                }
                if (state is SocialLinksError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (state is SocialLinksLoaded) {
                  return ListView.builder(
                    itemCount: state.links.length,
                    itemBuilder: (context, index) {
                      final link = state.links[index];
                      return _buildManagementCard(
                        title: link.name,
                        subtitle: link.url,
                        iconKey: link.iconName,
                        onEdit: () => _showAddEditSocialDialog(link),
                        onDelete: () => _confirmDeleteSocial(link.id),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementCard({
    required String title,
    required String subtitle,
    String? imageUrl,
    String? iconKey,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return PremiumCard(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : null,
            backgroundColor: AppColors.bgDark,
            radius: 25,
            child: imageUrl == null || imageUrl.isEmpty
                ? FaIcon(
                    SocialIconHelper.getIcon(iconKey ?? ''),
                    color: AppColors.gold,
                    size: 20,
                  )
                : null,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textDim,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red, size: 20),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  Widget _buildResumeTab() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CV & Resume Management',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 28),
              ),
              BlocBuilder<ResumeCubit, ResumeState>(
                builder: (context, state) {
                  return PremiumButton(
                    text: state is ResumeUploading
                        ? 'UPLOADING...'
                        : 'UPLOAD NEW CV (PDF)',
                    onPressed: state is ResumeUploading
                        ? () {}
                        : _pickAndUploadCV,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: BlocConsumer<ResumeCubit, ResumeState>(
              listener: (context, state) {
                if (state is ResumeSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                if (state is ResumeError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return BlocBuilder<ResumeCubit, ResumeState>(
                  builder: (context, state) {
                    if (state is ResumeLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.gold),
                      );
                    }

                    final metadata = (state is ResumeMetadataLoaded)
                        ? state.metadata
                        : null;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildManagementCard(
                          title: 'Official CV',
                          subtitle: metadata != null
                              ? 'Last updated: ${metadata.lastUpdated.toLocal()}'
                              : 'No CV uploaded yet',
                          iconKey: 'pdf',
                          onEdit: _pickAndUploadCV,
                          onDelete: () {}, // Optional: Add delete functionality
                        ),
                        if (state is ResumeUploading) ...[
                          const SizedBox(height: 24),
                          LinearProgressIndicator(
                            value: state.progress,
                            color: AppColors.gold,
                            backgroundColor: Colors.white10,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Uploading to Firebase Storage...',
                            style: TextStyle(color: AppColors.textDim),
                          ),
                        ],
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
