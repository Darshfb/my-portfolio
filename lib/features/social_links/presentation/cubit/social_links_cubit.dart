
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/social_link.dart';
import '../../domain/repositories/social_links_repository.dart';
import 'social_links_state.dart';

@injectable
class SocialLinksCubit extends Cubit<SocialLinksState> {
  final SocialLinksRepository _repository;

  SocialLinksCubit(this._repository) : super(SocialLinksInitial());

  Future<void> fetchSocialLinks() async {
    emit(SocialLinksLoading());
    try {
      final links = await _repository.getSocialLinks();
      emit(SocialLinksLoaded(links));
    } catch (e) {
      emit(SocialLinksError(e.toString()));
    }
  }

  Future<void> addSocialLink(SocialLink link) async {
    try {
      await _repository.addSocialLink(link);
      fetchSocialLinks();
    } catch (e) {
      emit(SocialLinksError(e.toString()));
    }
  }

  Future<void> updateSocialLink(SocialLink link) async {
    try {
      await _repository.updateSocialLink(link);
      fetchSocialLinks();
    } catch (e) {
      emit(SocialLinksError(e.toString()));
    }
  }

  Future<void> deleteSocialLink(String id) async {
    try {
      await _repository.deleteSocialLink(id);
      fetchSocialLinks();
    } catch (e) {
      emit(SocialLinksError(e.toString()));
    }
  }
}
