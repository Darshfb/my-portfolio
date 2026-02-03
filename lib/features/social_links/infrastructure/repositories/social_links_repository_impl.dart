
import 'package:injectable/injectable.dart';
import '../../domain/entities/social_link.dart';
import '../../domain/repositories/social_links_repository.dart';
import '../datasources/social_links_remote_datasource.dart';
import '../models/social_link_model.dart';

@LazySingleton(as: SocialLinksRepository)
class SocialLinksRepositoryImpl implements SocialLinksRepository {
  final SocialLinksRemoteDatasource _remoteDatasource;

  SocialLinksRepositoryImpl(this._remoteDatasource);

  @override
  Future<List<SocialLink>> getSocialLinks() async {
    return await _remoteDatasource.getSocialLinks();
  }

  @override
  Future<void> addSocialLink(SocialLink link) async {
    await _remoteDatasource.addSocialLink(SocialLinkModel.fromEntity(link));
  }

  @override
  Future<void> updateSocialLink(SocialLink link) async {
    await _remoteDatasource.updateSocialLink(SocialLinkModel.fromEntity(link));
  }

  @override
  Future<void> deleteSocialLink(String id) async {
    await _remoteDatasource.deleteSocialLink(id);
  }
}
