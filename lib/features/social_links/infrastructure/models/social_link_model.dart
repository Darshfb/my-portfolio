
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/social_link.dart';

part 'social_link_model.g.dart';

@JsonSerializable()
class SocialLinkModel extends SocialLink {
  const SocialLinkModel({
    required super.id,
    required super.name,
    required super.url,
    required super.iconName,
  });

  factory SocialLinkModel.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLinkModelToJson(this);

  factory SocialLinkModel.fromEntity(SocialLink entity) => SocialLinkModel(
        id: entity.id,
        name: entity.name,
        url: entity.url,
        iconName: entity.iconName,
      );
}
