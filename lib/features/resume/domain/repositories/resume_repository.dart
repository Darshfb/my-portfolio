
import '../../domain/entities/resume_metadata.dart';
import 'dart:typed_data';

abstract class ResumeRepository {
  Future<ResumeMetadata?> getResumeMetadata();
  Future<void> updateResumeMetadata(ResumeMetadata metadata);
  Future<String> uploadCV(Uint8List fileBytes, String fileName);
}
