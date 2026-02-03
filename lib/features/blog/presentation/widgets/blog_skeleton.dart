import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';

class BlogSkeleton extends StatelessWidget {
  const BlogSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _skelLine(width: 80, height: 10),
                  const SizedBox(height: 12),
                  _skelLine(width: double.infinity, height: 20),
                  const SizedBox(height: 8),
                  _skelLine(width: 150, height: 20),
                  const SizedBox(height: 12),
                  _skelLine(width: double.infinity, height: 12),
                  const SizedBox(height: 6),
                  _skelLine(width: double.infinity, height: 12),
                  const Spacer(),
                  const Divider(color: Colors.white10, height: 24),
                  Row(
                    children: [
                      _skelLine(width: 40, height: 10),
                      const SizedBox(width: 16),
                      _skelLine(width: 30, height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate(onPlay: (controller) => controller.repeat())
     .shimmer(duration: 1500.ms, color: AppColors.gold.withOpacity(0.05));
  }

  Widget _skelLine({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }
}
