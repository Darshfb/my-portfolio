
import 'package:equatable/equatable.dart';

class SocialLink extends Equatable {
  final String id;
  final String name;
  final String url;
  final String iconName; // e.g., 'linkedin', 'github', 'twitter'

  const SocialLink({
    required this.id,
    required this.name,
    required this.url,
    required this.iconName,
  });

  @override
  List<Object?> get props => [id, name, url, iconName];
}
