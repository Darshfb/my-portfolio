import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_colors.dart';
import '../../features/social_links/presentation/cubit/social_links_cubit.dart';
import '../../features/social_links/presentation/cubit/social_links_state.dart';
import '../../features/social_links/presentation/utils/social_icon_helper.dart';

class PremiumButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;

  const PremiumButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.gold, width: 2),
            color: isSecondary ? Colors.transparent : AppColors.gold.withOpacity(0.1),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.gold,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ).animate(onPlay: (controller) => controller.repeat(reverse: true))
          .shimmer(duration: 2.seconds, color: AppColors.gold.withOpacity(0.3)),
    );
  }
}

class PremiumCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const PremiumCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: child,
    ).animate().fadeIn(duration: 600.ms).moveY(begin: 20, end: 0);
  }
}
class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Column(
        children: [
          const Divider(color: Colors.white10),
          const SizedBox(height: 48),
          
          // Dynamic Social Links
          BlocBuilder<SocialLinksCubit, SocialLinksState>(
            builder: (context, state) {
              if (state is SocialLinksLoaded && state.links.isNotEmpty) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: state.links.map((link) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: IconButton(
                        icon: FaIcon(SocialIconHelper.getIcon(link.iconName), color: AppColors.gold, size: 24),
                        onPressed: () => launchUrl(Uri.parse(link.url)),
                        tooltip: link.name,
                      ).animate(onPlay: (c) => c.repeat(reverse: true)).shimmer(duration: 3.seconds, delay: 1.seconds),
                    );
                  }).toList(),
                );
              }
              return const SizedBox();
            },
          ),
          
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ).animate(onPlay: (controller) => controller.repeat())
                        .shimmer(duration: 2.seconds),
                    const SizedBox(width: 8),
                    Text(
                      'Ready for new projects',
                      style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '© ${DateTime.now().year} Mostafa. Professional Portfolio.',
            style: TextStyle(color: AppColors.textDim.withOpacity(0.5), fontSize: 14, letterSpacing: 1.2),
          ),
        ],
      ),
    );
  }
}
