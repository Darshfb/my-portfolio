// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) =>
    _ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      description: json['description'] as String,
      role: json['role'] as String,
      type: json['type'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      coverImage: json['coverImage'] as String,
      galleryImages:
          (json['galleryImages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      technologies: (json['technologies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      testingTypes:
          (json['testingTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      qaMetrics: json['qaMetrics'] as Map<String, dynamic>?,
      starNarrative: json['starNarrative'] as Map<String, dynamic>?,
      testimonial: json['testimonial'] as Map<String, dynamic>?,
      mainUrl: json['mainUrl'] as String?,
      links:
          (json['links'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      orderIndex: (json['orderIndex'] as num).toInt(),
      isPublished: json['isPublished'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProjectModelToJson(_ProjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'role': instance.role,
      'type': instance.type,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'coverImage': instance.coverImage,
      'galleryImages': instance.galleryImages,
      'technologies': instance.technologies,
      'testingTypes': instance.testingTypes,
      'qaMetrics': instance.qaMetrics,
      'starNarrative': instance.starNarrative,
      'testimonial': instance.testimonial,
      'mainUrl': instance.mainUrl,
      'links': instance.links,
      'orderIndex': instance.orderIndex,
      'isPublished': instance.isPublished,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
