import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/blog_post.dart';

class BlogCard extends StatefulWidget {
  final BlogPost post;
  final int index;

  const BlogCard({super.key, required this.post, required this.index});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final readingTime = (widget.post.content.split(' ').length / 200).ceil();
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.push('/blog/${widget.post.id}'),
        child: AnimatedScale(
          scale: _isHovered ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered ? AppColors.gold.withOpacity(0.3) : Colors.white.withOpacity(0.05),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
                if (_isHovered)
                  BoxShadow(
                    color: AppColors.gold.withOpacity(0.05),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      Expanded(
                        flex: 5,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Hero(
                              tag: 'blog_image_${widget.post.id}',
                              child: widget.post.imageUrl != null
                                  ? CachedNetworkImage(
                                      imageUrl: widget.post.imageUrl!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        color: AppColors.primaryDark,
                                        child: const Center(
                                          child: CircularProgressIndicator(color: AppColors.gold),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Container(
                                        color: AppColors.primaryDark,
                                        child: const Icon(Icons.broken_image_outlined, color: AppColors.textDim),
                                      ),
                                    )
                                  : Container(color: AppColors.primaryDark),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    AppColors.primaryDark.withOpacity(0.8),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              left: 12,
                              child: _buildTag(widget.post.tags.first),
                            ),
                          ],
                        ),
                      ),
                      // Content Section
                      Expanded(
                        flex: 6,
                        child: Directionality(
                          textDirection: widget.post.language == 'Arabic' ? TextDirection.rtl : TextDirection.ltr,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('MMM dd, yyyy').format(widget.post.publishDate).toUpperCase(),
                                  style: const TextStyle(
                                    color: AppColors.gold,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  widget.post.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  widget.post.summary,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                ),
                                const Spacer(),
                                const Divider(color: Colors.white10, height: 24),
                                Row(
                                  children: [
                                    _infoItem(Icons.access_time_rounded, '$readingTime MIN'),
                                    const SizedBox(width: 16),
                                    _infoItem(Icons.favorite_rounded, '${widget.post.likeCount}'),
                                    const SizedBox(width: 16),
                                    _infoItem(Icons.chat_bubble_rounded, '${widget.post.commentCount}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ).animate(delay: (100 * widget.index).ms).fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.gold.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.gold.withOpacity(0.5), width: 0.5),
      ),
      child: Text(
        tag.toUpperCase(),
        style: const TextStyle(color: AppColors.gold, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textDim),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(color: AppColors.textDim, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
