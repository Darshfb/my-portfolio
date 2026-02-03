import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/blog_post.dart';

class BlogPostModel extends BlogPost {
  const BlogPostModel({
    required super.id,
    required super.title,
    required super.summary,
    required super.content,
    required super.author,
    required super.publishDate,
    super.imageUrl,
    required super.tags,
    super.likeCount,
    super.commentCount,
    super.language = 'English',
  });

  factory BlogPostModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BlogPostModel(
      id: doc.id,
      title: data['title'] ?? '',
      summary: data['summary'] ?? '',
      content: data['content'] ?? '',
      author: data['author'] ?? '',
      publishDate: (data['publishDate'] as Timestamp).toDate(),
      imageUrl: data['imageUrl'],
      tags: List<String>.from(data['tags'] ?? []),
      likeCount: data['likeCount'] ?? 0,
      commentCount: data['commentCount'] ?? 0,
      language: data['language'] ?? 'English',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'summary': summary,
      'content': content,
      'author': author,
      'publishDate': Timestamp.fromDate(publishDate),
      'imageUrl': imageUrl,
      'tags': tags,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'language': language,
    };
  }
}
