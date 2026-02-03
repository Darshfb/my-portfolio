import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/layout/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/blog_bloc.dart';
import '../bloc/blog_event.dart';
import '../bloc/blog_state.dart';
import '../widgets/blog_card.dart';
import '../widgets/blog_skeleton.dart';
import '../widgets/category_chips.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  String _selectedCategory = 'ALL';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(const FetchBlogPosts());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final double horizontalPadding = isMobile ? 24 : MediaQuery.of(context).size.width * 0.1;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 140), // Spacing for floating header
            
            // Header Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'blog.title'.tr(),
                    style: const TextStyle(
                      color: AppColors.gold,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'blog.subtitle'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Filter \u0026 Search Row
                  if (!isMobile)
                    Row(
                      children: [
                        Expanded(
                          child: CategoryChips(
                            categories: const ['FLUTTER', 'DART', 'FIREBASE', 'QA', 'UI/UX'],
                            selectedCategory: _selectedCategory,
                            onCategorySelected: (cat) => setState(() => _selectedCategory = cat),
                          ),
                        ),
                        const SizedBox(width: 40),
                        _buildSearchBar(),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildSearchBar(),
                        const SizedBox(height: 20),
                        CategoryChips(
                          categories: const ['FLUTTER', 'DART', 'FIREBASE', 'QA', 'UI/UX'],
                          selectedCategory: _selectedCategory,
                          onCategorySelected: (cat) => setState(() => _selectedCategory = cat),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // Blog Posts Grid/List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: BlocBuilder<BlogBloc, BlogState>(
                builder: (context, state) {
                  if (state is BlogLoading) {
                    return _buildGrid(context, isSkeleton: true);
                  } else if (state is BlogPostsLoaded) {
                    final filteredPosts = state.posts.where((post) {
                      final matchesCategory = _selectedCategory == 'ALL' || post.tags.contains(_selectedCategory);
                      final matchesSearch = post.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                          post.summary.toLowerCase().contains(_searchQuery.toLowerCase());
                      return matchesCategory && matchesSearch;
                    }).toList();

                    if (filteredPosts.isEmpty) {
                      return _buildEmptyState();
                    }

                    return _buildGrid(context, posts: filteredPosts);
                  } else if (state is BlogError) {
                    return Center(
                      child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)),
                    );
                  }
                  
                  // If we are in BlogPostLoaded (single post detail) or other state, 
                  // we only trigger a fetch if this page is actually visible to the user.
                  final bool isCurrent = ModalRoute.of(context)?.isCurrent ?? false;
                  if (isCurrent && state is! BlogLoading) {
                    Future.microtask(() => context.read<BlogBloc>().add(const FetchBlogPosts()));
                  }
                  return _buildGrid(context, isSkeleton: true);
                },
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: 300,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val),
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'blog.search_placeholder'.tr(),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14),
          prefixIcon: Icon(Icons.search_rounded, color: Colors.white.withOpacity(0.3), size: 18),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, {List? posts, bool isSkeleton = false}) {
    final int crossAxisCount = ResponsiveLayout.isMobile(context) 
        ? 1 
        : ResponsiveLayout.isTablet(context) ? 2 : 3;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: 0.85,
      ),
      itemCount: isSkeleton ? 6 : posts!.length,
      itemBuilder: (context, index) {
        if (isSkeleton) return const BlogSkeleton();
        return BlogCard(post: posts![index], index: index);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 60),
          Icon(Icons.article_outlined, size: 80, color: Colors.white.withOpacity(0.1)),
          const SizedBox(height: 24),
          Text(
            'blog.no_posts'.tr(),
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'blog.no_posts_desc'.tr(),
            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
          ),
        ],
      ),
    );
  }
}
