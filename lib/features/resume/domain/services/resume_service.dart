import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:myprofile/features/projects/domain/entities/project.dart';

@lazySingleton
class ResumeService {
  Future<Uint8List> generateResume({
    required String name,
    required String role,
    required String contact,
    required List<Project> projects,
  }) async {
    final pdf = pw.Document();

    // Use a professional font
    final font = await PdfGoogleFonts.interRegular();
    final fontBold = await PdfGoogleFonts.interBold();
    final fontItalic = await PdfGoogleFonts.interItalic();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        theme: pw.ThemeData.withFont(
          base: font,
          bold: fontBold,
          italic: fontItalic,
        ),
        build: (pw.Context context) {
          final textStyle = pw.TextStyle(font: font);
          final boldStyle = pw.TextStyle(font: fontBold, fontWeight: pw.FontWeight.bold);
          final italicStyle = pw.TextStyle(font: fontItalic, fontStyle: pw.FontStyle.italic);

          return [
            // Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(name, style: boldStyle.copyWith(fontSize: 32, color: PdfColors.black)),
                    pw.Text(role, style: textStyle.copyWith(fontSize: 18, color: PdfColors.grey700)),
                  ],
                ),
                pw.Text(contact, style: textStyle.copyWith(fontSize: 12, color: PdfColors.grey600)),
              ],
            ),
            pw.Divider(thickness: 1, color: PdfColors.grey300),
            pw.SizedBox(height: 24),

            // Profile Summary
            pw.Text('SUMMARY', style: boldStyle.copyWith(fontSize: 14, color: PdfColors.blueGrey800)),
            pw.SizedBox(height: 8),
            pw.Text(
              'Detail-oriented professional with extensive experience in Flutter development and Quality Assurance. Proven track record of delivering high-quality, scalable mobile applications and implementing robust automation frameworks.',
              style: textStyle.copyWith(fontSize: 12, lineSpacing: 1.5),
            ),
            pw.SizedBox(height: 24),

            // Selected Projects
            pw.Text('KEY PROJECTS', style: boldStyle.copyWith(fontSize: 14, color: PdfColors.blueGrey800)),
            pw.Divider(thickness: 0.5, color: PdfColors.grey300),
            pw.SizedBox(height: 12),

            ...projects.map((p) => pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 24),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(p.title, style: boldStyle.copyWith(fontSize: 14)),
                      pw.Text(p.role, style: italicStyle.copyWith(fontSize: 10, color: PdfColors.grey700)),
                    ],
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(p.technologies.join(' | '), style: textStyle.copyWith(fontSize: 9, color: PdfColors.blue700)),
                  pw.SizedBox(height: 8),
                  
                  if (p.starNarrative != null) ...[
                     pw.Bullet(
                       text: p.starNarrative!.result, 
                       style: textStyle.copyWith(fontSize: 11),
                       bulletMargin: const pw.EdgeInsets.only(top: 1.5, right: 5),
                     ),
                  ] else ...[
                     pw.Text(p.description, style: textStyle.copyWith(fontSize: 11), maxLines: 3),
                  ],
                  
                  if (p.qaMetrics != null && p.qaMetrics!.isNotEmpty) ...[
                    pw.SizedBox(height: 4),
                    pw.Row(
                      children: p.qaMetrics!.entries.map((e) => pw.Padding(
                        padding: const pw.EdgeInsets.only(right: 12),
                        child: pw.Text('${e.key}: ${e.value}', style: boldStyle.copyWith(fontSize: 9, color: PdfColors.green700)),
                      )).toList(),
                    ),
                  ],
                ],
              ),
            )),

            // Skills Section
            pw.SizedBox(height: 24),
            pw.Text('CORE COMPETENCIES', style: boldStyle.copyWith(fontSize: 14, color: PdfColors.blueGrey800)),
            pw.Divider(thickness: 0.5, color: PdfColors.grey300),
            pw.SizedBox(height: 12),
            pw.Wrap(
              spacing: 24,
              runSpacing: 8,
              children: [
                pw.Text('• Flutter & Dart', style: textStyle.copyWith(fontSize: 11)),
                pw.Text('• QA Automation', style: textStyle.copyWith(fontSize: 11)),
                pw.Text('• Firebase Integration', style: textStyle.copyWith(fontSize: 11)),
                pw.Text('• Clean Architecture', style: textStyle.copyWith(fontSize: 11)),
                pw.Text('• CI/CD Pipelines', style: textStyle.copyWith(fontSize: 11)),
              ],
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }
}
