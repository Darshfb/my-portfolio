// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialLinkModel _$SocialLinkModelFromJson(Map<String, dynamic> json) =>
    SocialLinkModel(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      iconName: json['iconName'] as String,
    );

Map<String, dynamic> _$SocialLinkModelToJson(SocialLinkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'iconName': instance.iconName,
    };
