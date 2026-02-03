
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/resume_metadata.dart';
import '../../domain/repositories/resume_repository.dart';
import 'resume_state.dart';

@injectable
class ResumeCubit extends Cubit<ResumeState> {
  final ResumeRepository _repository;

  ResumeCubit(this._repository) : super(ResumeInitial());

  Future<void> fetchResumeMetadata() async {
    emit(ResumeLoading());
    try {
      final metadata = await _repository.getResumeMetadata();
      emit(ResumeMetadataLoaded(metadata));
    } catch (e) {
      emit(ResumeError(e.toString()));
    }
  }

  Future<void> uploadCV(Uint8List bytes, String fileName) async {
    emit(const ResumeUploading(0.5)); // Simplified progress for now
    try {
      final url = await _repository.uploadCV(bytes, fileName);
      final metadata = ResumeMetadata(
        cvUrl: url,
        lastUpdated: DateTime.now(),
      );
      await _repository.updateResumeMetadata(metadata);
      emit(const ResumeSuccess('CV uploaded successfully!'));
      fetchResumeMetadata();
    } catch (e) {
      emit(ResumeError(e.toString()));
    }
  }
}
