
import '../entities/social_link.dart';

abstract class SocialLinksRepository {
  Future<List<SocialLink>> getSocialLinks();
  Future<void> addSocialLink(SocialLink link);
  Future<void> updateSocialLink(SocialLink link);
  Future<void> deleteSocialLink(String id);
}
