import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/layout/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/blog_bloc.dart';
import '../bloc/blog_event.dart';
import '../bloc/blog_state.dart';
import '../widgets/comment_section.dart';

class BlogDetailsPage extends StatefulWidget {
  final String postId;
  const BlogDetailsPage({super.key, required this.postId});

  @override
  State<BlogDetailsPage> createState() => _BlogDetailsPageState();
}

class _BlogDetailsPageState extends State<BlogDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(FetchBlogPostById(widget.postId));
    _scrollController.addListener(() {
      if (_scrollController.offset > 800) {
        if (!_showBackToTop) setState(() => _showBackToTop = true);
      } else {
        if (_showBackToTop) setState(() => _showBackToTop = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _shareVia(String platform) {
    final url = Uri.base.toString();
    final text = 'Check out this post: ${Uri.base}';
    
    switch (platform) {
      case 'COPY':
        Clipboard.setData(ClipboardData(text: url));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('blog.link_copied'.tr())),
        );
        break;
      case 'LINKEDIN':
        launchUrl(Uri.parse('https://www.linkedin.com/sharing/share-offsite/?url=$url'));
        break;
      case 'X':
        launchUrl(Uri.parse('https://twitter.com/intent/tweet?text=$text'));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final double horizontalPadding = isMobile ? 24 : MediaQuery.of(context).size.width * 0.2;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: _showBackToTop ? _buildBackToTop() : null,
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is CommentAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('blog.comment_posted'.tr())),
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading && state is! BlogPostLoaded) {
            return const Center(child: CircularProgressIndicator(color: AppColors.gold));
          } else if (state is BlogPostLoaded) {
            final post = state.post;
            final readingTime = (post.content.split(' ').length / 200).ceil();

            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 140), // Spacing for floating header
                  
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : horizontalPadding),
                    child: Directionality(
                      textDirection: post.language == 'Arabic' ? TextDirection.rtl : TextDirection.ltr,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Back Button
                          _buildBackButton(),
                          const SizedBox(height: 40),
                          
                          // Metadata
                          Row(
                            children: [
                              Text(
                                post.tags.first.toUpperCase(),
                                style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '–  $readingTime ${'blog.min_read'.tr()}',
                                style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // Title
                          Text(
                            post.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 32 : 48,
                              fontWeight: FontWeight.w900,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 30),
                          
                          // Author \u0026 Date
                          _buildAuthorRow(post),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),

                  // Hero Image
                  Hero(
                    tag: 'blog_image_${post.id}',
                    child: Container(
                      width: double.infinity,
                      height: isMobile ? 300 : 500,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(post.imageUrl ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.primaryDark.withOpacity(0.2),
                              AppColors.primaryDark,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Content Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : horizontalPadding),
                    child: Directionality(
                      textDirection: post.language == 'Arabic' ? TextDirection.rtl : TextDirection.ltr,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 60),
                          
                          // Share \u0026 Like Sidebar (Simulated in content for now)
                          _buildInteractionsRow(post),
                          
                          const SizedBox(height: 40),
                          
                          // Markdown Content
                          MarkdownBody(
                            data: post.content,
                            styleSheet: MarkdownStyleSheet(
                              p: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18, height: 1.8),
                              h1: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                              h2: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                              h3: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                              listBullet: TextStyle(color: AppColors.gold.withOpacity(0.8)),
                              code: const TextStyle(backgroundColor: Colors.white10, color: AppColors.gold),
                              blockquote: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 16, fontStyle: FontStyle.italic),
                              blockquoteDecoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                border: const Border(left: BorderSide(color: AppColors.gold, width: 4)),
                                borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
                              ),
                              blockquotePadding: const EdgeInsets.all(20),
                            ),
                          ),
                          
                          const SizedBox(height: 100),
                          const Divider(color: Colors.white10, height: 1),
                          const SizedBox(height: 60),
                          
                          // Comment Section
                          CommentSection(postId: post.id, comments: state.comments),
                          
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is BlogError) {
            return Center(child: Text('${'common.error'.tr()}: ${state.message}', style: const TextStyle(color: Colors.orange)));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          context.go('/blog');
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.arrow_back_rounded, color: AppColors.gold, size: 20),
          const SizedBox(width: 8),
          Text(
            'blog.back_to_blog'.tr(),
            style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorRow(post) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gold.withOpacity(0.1),
            border: Border.all(color: AppColors.gold.withOpacity(0.5)),
          ),
          child: const Icon(Icons.person_rounded, color: AppColors.gold),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.author.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              DateFormat('MMMM dd, yyyy', context.locale.toString()).format(post.publishDate),
              style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInteractionsRow(post) {
    return Row(
      children: [
        _interactionButton(
          icon: Icons.favorite_border_rounded,
          label: post.likeCount.toString(),
          onTap: () => context.read<BlogBloc>().add(LikeBlogPost(post.id)),
        ),
        const SizedBox(width: 24),
        _interactionButton(
          icon: Icons.chat_bubble_outline_rounded,
          label: post.commentCount.toString(),
          onTap: () {
            // Scroll to comments
          },
        ),
        const Spacer(),
        _shareIcon(Icons.link_rounded, () => _shareVia('COPY')),
        const SizedBox(width: 16),
        _shareIcon(Icons.share_rounded, () => _shareVia('LINKEDIN')),
        const SizedBox(width: 16),
        _shareIcon(Icons.alternate_email_rounded, () => _shareVia('X')),
      ],
    );
  }

  Widget _interactionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.gold, size: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _shareIcon(IconData icon, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white.withOpacity(0.5), size: 22),
      hoverColor: AppColors.gold.withOpacity(0.1),
    );
  }

  Widget _buildBackToTop() {
    return FloatingActionButton(
      onPressed: () => _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut),
      backgroundColor: AppColors.gold,
      child: const Icon(Icons.arrow_upward_rounded, color: AppColors.primaryDark),
    );
  }
}
