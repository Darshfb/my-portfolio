
import 'package:equatable/equatable.dart';
import '../../domain/entities/social_link.dart';

abstract class SocialLinksState extends Equatable {
  const SocialLinksState();

  @override
  List<Object?> get props => [];
}

class SocialLinksInitial extends SocialLinksState {}

class SocialLinksLoading extends SocialLinksState {}

class SocialLinksLoaded extends SocialLinksState {
  final List<SocialLink> links;

  const SocialLinksLoaded(this.links);

  @override
  List<Object?> get props => [links];
}

class SocialLinksError extends SocialLinksState {
  final String message;

  const SocialLinksError(this.message);

  @override
  List<Object?> get props => [message];
}
