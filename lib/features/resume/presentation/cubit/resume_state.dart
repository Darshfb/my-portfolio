
import 'package:equatable/equatable.dart';
import '../../domain/entities/resume_metadata.dart';

abstract class ResumeState extends Equatable {
  const ResumeState();

  @override
  List<Object?> get props => [];
}

class ResumeInitial extends ResumeState {}

class ResumeLoading extends ResumeState {}

class ResumeMetadataLoaded extends ResumeState {
  final ResumeMetadata? metadata;

  const ResumeMetadataLoaded(this.metadata);

  @override
  List<Object?> get props => [metadata];
}

class ResumeUploading extends ResumeState {
  final double progress;

  const ResumeUploading(this.progress);

  @override
  List<Object?> get props => [progress];
}

class ResumeSuccess extends ResumeState {
  final String message;

  const ResumeSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ResumeError extends ResumeState {
  final String message;

  const ResumeError(this.message);

  @override
  List<Object?> get props => [message];
}
