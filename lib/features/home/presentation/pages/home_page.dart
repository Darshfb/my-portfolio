import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:seo/seo.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/premium_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;

    return Title(
      title: 'Mostafa | Premium Flutter Expert',
      color: AppColors.gold,
      child: Seo.text(
        text: 'Mostafa - Senior Flutter Developer & QA Lead specializing in high-performance mobile apps and automated testing.',
        child: Scaffold(
          backgroundColor: AppColors.bgDark,
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              // 1. Hero Section
              Container(
                height: isMobile ? 600 : 800,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.bgDark, AppColors.primaryDark],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: isMobile ? -150 : -100,
                      top: -100,
                      child: Container(
                        width: 500,
                        height: 500,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.gold.withOpacity(0.03),
                        ),
                      ).animate(onPlay: (c) => c.repeat(reverse: true))
                       .scale(duration: 5.seconds, begin: const Offset(1, 1), end: const Offset(1.2, 1.2)),
                    ),
                    centerHeroSection(context, isMobile),
                  ],
                ),
              ),
              
              // 2. Expertise Section
              _buildSection(
                context,
                title: 'home.core_expertise'.tr(),
                subtitle: 'home.core_expertise_subtitle'.tr(),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: constraints.maxWidth < 900 ? 1 : 2,
                      childAspectRatio: constraints.maxWidth < 600 ? 3 : 2.5,
                      crossAxisSpacing: 32,
                      mainAxisSpacing: 32,
                      children: [
                        _buildExpertiseCard(Icons.flutter_dash, 'home.expertise_flutter'.tr(), 'home.expertise_flutter_desc'.tr()),
                        _buildExpertiseCard(Icons.security, 'home.expertise_qa'.tr(), 'home.expertise_qa_desc'.tr()),
                        _buildExpertiseCard(Icons.architecture, 'home.expertise_clean'.tr(), 'home.expertise_clean_desc'.tr()),
                        _buildExpertiseCard(Icons.speed, 'home.expertise_perf'.tr(), 'home.expertise_perf_desc'.tr()),
                      ],
                    );
                  }
                ),
              ),
    
              // 3. Testimonials Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 80),
                color: AppColors.primaryDark.withOpacity(0.5),
                child: Column(
                  children: [
                    Text(
                      'home.validation_title'.tr(), 
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.gold, 
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'home.validation_subtitle'.tr(), 
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.textDim.withOpacity(0.7), fontSize: 18)
                      ),
                    ),
                    const SizedBox(height: 64),
                    _buildTestimonialPlaceholder(),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms),
    
              const PortfolioFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget centerHeroSection(BuildContext context, bool isMobile) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.code_rounded, color: AppColors.gold, size: 64)
                .animate().fadeIn().scale(),
            const SizedBox(height: 24),
            Text(
              'home.name'.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: isMobile ? 54 : 84, 
                color: AppColors.gold, 
                fontWeight: FontWeight.w900,
                letterSpacing: -2,
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 8),
            Text(
              'home.role'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPremium, 
                fontSize: isMobile ? 18 : 28, 
                letterSpacing: isMobile ? 2 : 4, 
                fontWeight: FontWeight.w300
              ),
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 48),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              runSpacing: 16,
              children: [
                PremiumButton(
                  text: 'home.cta_projects'.tr().toUpperCase(),
                  onPressed: () => context.go('/projects'),
                ),
                PremiumButton(
                  text: 'home.ct_resume'.tr().toUpperCase(), // Note: Added a new key in subsequent step if missing or use existing resume title
                  isSecondary: true,
                  onPressed: () => context.go('/resume'),
                ),
              ],
            ).animate().fadeIn(delay: 600.ms).scale(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required String subtitle, required Widget child}) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: isMobile ? 20 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, 
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: isMobile ? 36 : 48, 
              color: Colors.white,
              fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(height: 16),
          Text(subtitle, style: const TextStyle(color: AppColors.textDim, fontSize: 20)),
          const SizedBox(height: 64),
          child,
        ],
      ),
    );
  }

  Widget _buildExpertiseCard(IconData icon, String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.1), 
              borderRadius: BorderRadius.circular(12)
            ),
            child: Icon(icon, color: AppColors.gold, size: 32),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title, 
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 4),
                Text(
                  desc, 
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.textDim, fontSize: 14)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialPlaceholder() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      padding: const EdgeInsets.all(40),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.gold.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          const Icon(Icons.format_quote_rounded, color: AppColors.gold, size: 48),
          const SizedBox(height: 24),
          Text(
            'home.testimonial_1'.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic, height: 1.6),
          ),
          const SizedBox(height: 32),
          Text(
            'home.testimonial_1_role'.tr(), 
            style: const TextStyle(color: AppColors.gold, fontSize: 18, fontWeight: FontWeight.bold)
          ),
          Text(
            'home.testimonial_1_author'.tr(), 
            style: const TextStyle(color: AppColors.textDim, fontSize: 14)
          ),
        ],
      ),
    ).animate().fadeIn().scale();
  }
}