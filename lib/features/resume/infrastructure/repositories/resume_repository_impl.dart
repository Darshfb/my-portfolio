
import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import '../../domain/entities/resume_metadata.dart';
import '../../domain/repositories/resume_repository.dart';
import '../datasources/resume_remote_datasource.dart';
import '../models/resume_metadata_model.dart';

@LazySingleton(as: ResumeRepository)
class ResumeRepositoryImpl implements ResumeRepository {
  final ResumeRemoteDatasource _remoteDatasource;

  ResumeRepositoryImpl(this._remoteDatasource);

  @override
  Future<ResumeMetadata?> getResumeMetadata() {
    return _remoteDatasource.getResumeMetadata();
  }

  @override
  Future<void> updateResumeMetadata(ResumeMetadata metadata) {
    return _remoteDatasource.updateResumeMetadata(
      ResumeMetadataModel.fromEntity(metadata),
    );
  }

  @override
  Future<String> uploadCV(Uint8List fileBytes, String fileName) {
    return _remoteDatasource.uploadCV(fileBytes, fileName);
  }
}
