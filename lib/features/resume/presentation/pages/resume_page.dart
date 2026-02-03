import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:myprofile/core/theme/app_colors.dart';
import 'package:myprofile/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:myprofile/features/resume/domain/services/resume_service.dart';
import 'package:myprofile/features/resume/presentation/cubit/resume_cubit.dart';
import 'package:myprofile/features/resume/presentation/cubit/resume_state.dart';
import '../../../../core/widgets/premium_widgets.dart';

import 'package:http/http.dart' as http;

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Title(
      title: 'Mostafa | Professional Resume',
      color: AppColors.gold,
      child: Padding(
        padding: const EdgeInsets.only(top: 80), // For floating header
        child: BlocBuilder<ResumeCubit, ResumeState>(
          builder: (context, resumeState) {
            if (resumeState is ResumeLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.gold));
            }

            final metadata = (resumeState is ResumeMetadataLoaded) ? resumeState.metadata : null;

            return isWide 
              ? _buildWebLayout(context, metadata)
              : _buildMobileLayout(context, metadata);
          },
        ),
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context, dynamic metadata) {
    return Row(
      children: [
        // Left Column: Profile & Download
        Container(
          width: 350,
          decoration: BoxDecoration(
            border: Border(right: BorderSide(color: Colors.white10)),
            color: Colors.white.withOpacity(0.02),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.gold, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gold.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 45,
                    backgroundColor: AppColors.bgDark,
                    backgroundImage: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/mostafaaboadscompany.firebasestorage.app/o/profile%2Fmyprofile.png?alt=media&token=26cd58db-99c6-4e87-a07f-20cd94e2ed73',
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text('home.name'.tr(), style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32)),
                Text('home.role'.tr(), 
                  style: const TextStyle(color: AppColors.gold, fontSize: 16, height: 1.5)),
                const SizedBox(height: 32),
                const Divider(color: Colors.white10),
                const SizedBox(height: 32),
                
                if (metadata?.cvUrl != null) ...[
                  PremiumButton(
                    text: 'resume.download_pdf'.tr().toUpperCase(),
                    onPressed: () => launchUrl(Uri.parse(metadata!.cvUrl)),
                  ),
                  const SizedBox(height: 12),
                  Text('resume.pdf_format'.tr(), 
                    style: const TextStyle(color: AppColors.textDim, fontSize: 12)),
                ] else ...[
                   Text('resume.updating'.tr(), 
                    style: const TextStyle(color: AppColors.textDim, fontStyle: FontStyle.italic)),
                ],
                
                const SizedBox(height: 48),
                _buildSkillBadge('resume.skill_1'.tr()),
                _buildSkillBadge('resume.skill_2'.tr()),
                _buildSkillBadge('resume.skill_3'.tr()),
                _buildSkillBadge('resume.skill_4'.tr()),
                
                const SizedBox(height: 64),
                const PortfolioFooter(),
              ],
            ),
          ),
        ),
        
        // Right Column: Document Preview
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('resume.preview'.tr(), 
                      style: const TextStyle(color: AppColors.textDim, letterSpacing: 2, fontSize: 13)),
                    const Icon(Icons.description_outlined, color: AppColors.gold, size: 18),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(child: _buildPdfContent(metadata?.cvUrl)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, dynamic metadata) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gold, width: 2),
            ),
            child: const CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.bgDark,
              backgroundImage: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/mostafaaboadscompany.firebasestorage.app/o/profile%2Fmyprofile.png?alt=media&token=26cd58db-99c6-4e87-a07f-20cd94e2ed73',
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('home.name'.tr(), style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28)),
          Text(
            'home.role'.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.gold, fontSize: 14),
          ),
          const SizedBox(height: 32),
          if (metadata?.cvUrl != null) ...[
             PremiumButton(
                text: 'DOWNLOAD COPY',
                onPressed: () => launchUrl(Uri.parse(metadata!.cvUrl)),
              ),
              const SizedBox(height: 32),
          ],
          SizedBox(
            height: 600,
            child: _buildPdfContent(metadata?.cvUrl),
          ),
          const SizedBox(height: 48),
          const PortfolioFooter(),
        ],
      ),
    );
  }

  Widget _buildPdfContent(String? cvUrl) {
    if (cvUrl == null) {
      return Center(
        child: Text('resume.no_cv'.tr(), style: const TextStyle(color: AppColors.textDim)),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, spreadRadius: 5),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: PdfPreview(
        build: (format) async {
          final response = await http.get(Uri.parse(cvUrl));
          return response.bodyBytes;
        },
        useActions: false,
        allowPrinting: true,
        allowSharing: true,
        canChangePageFormat: false,
        pdfFileName: 'Mostafa_Official_CV.pdf',
        loadingWidget: const Center(child: CircularProgressIndicator(color: AppColors.gold)),
      ),
    );
  }

  Widget _buildSkillBadge(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }
}
