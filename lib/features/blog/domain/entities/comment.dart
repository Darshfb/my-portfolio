import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String postId;
  final String username;
  final String text;
  final DateTime timestamp;

  const Comment({
    required this.id,
    required this.postId,
    required this.username,
    required this.text,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, postId, username, text, timestamp];
}
