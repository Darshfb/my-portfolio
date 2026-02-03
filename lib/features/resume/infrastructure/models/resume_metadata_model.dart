
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/resume_metadata.dart';

part 'resume_metadata_model.g.dart';

@JsonSerializable()
class ResumeMetadataModel extends ResumeMetadata {
  const ResumeMetadataModel({
    required super.cvUrl,
    required super.lastUpdated,
  });

  factory ResumeMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$ResumeMetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResumeMetadataModelToJson(this);

  factory ResumeMetadataModel.fromEntity(ResumeMetadata entity) =>
      ResumeMetadataModel(
        cvUrl: entity.cvUrl,
        lastUpdated: entity.lastUpdated,
      );
}
