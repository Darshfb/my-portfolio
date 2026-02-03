import 'package:equatable/equatable.dart';

class BlogPost extends Equatable {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String author;
  final DateTime publishDate;
  final String? imageUrl;
  final List<String> tags;
  final int likeCount;
  final int commentCount;
  final String language;

  const BlogPost({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.author,
    required this.publishDate,
    this.imageUrl,
    required this.tags,
    this.likeCount = 0,
    this.commentCount = 0,
    this.language = 'English',
  });

  @override
  List<Object?> get props => [
        id,
        title,
        summary,
        content,
        author,
        publishDate,
        imageUrl,
        tags,
        likeCount,
        commentCount,
        language,
      ];
}
