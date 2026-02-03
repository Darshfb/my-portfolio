// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_metadata_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResumeMetadataModel _$ResumeMetadataModelFromJson(Map<String, dynamic> json) =>
    ResumeMetadataModel(
      cvUrl: json['cvUrl'] as String,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$ResumeMetadataModelToJson(
  ResumeMetadataModel instance,
) => <String, dynamic>{
  'cvUrl': instance.cvUrl,
  'lastUpdated': instance.lastUpdated.toIso8601String(),
};
