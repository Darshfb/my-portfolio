import 'package:equatable/equatable.dart';
import '../../domain/entities/blog_post.dart';
import '../../domain/entities/comment.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object?> get props => [];
}

class FetchBlogPosts extends BlogEvent {
  final int limit;
  final String? startAfterId;

  const FetchBlogPosts({this.limit = 10, this.startAfterId});

  @override
  List<Object?> get props => [limit, startAfterId];
}

class FetchBlogPostById extends BlogEvent {
  final String id;

  const FetchBlogPostById(this.id);

  @override
  List<Object?> get props => [id];
}

class LikeBlogPost extends BlogEvent {
  final String postId;

  const LikeBlogPost(this.postId);

  @override
  List<Object?> get props => [postId];
}

class AddBlogComment extends BlogEvent {
  final Comment comment;

  const AddBlogComment(this.comment);

  @override
  List<Object?> get props => [comment];
}

class FetchComments extends BlogEvent {
  final String postId;

  const FetchComments(this.postId);

  @override
  List<Object?> get props => [postId];
}

class CreateBlogPostEvent extends BlogEvent {
  final BlogPost post;

  const CreateBlogPostEvent(this.post);

  @override
  List<Object?> get props => [post];
}

class UpdateBlogPostEvent extends BlogEvent {
  final BlogPost post;

  const UpdateBlogPostEvent(this.post);

  @override
  List<Object?> get props => [post];
}

class DeleteBlogPostEvent extends BlogEvent {
  final String id;

  const DeleteBlogPostEvent(this.id);

  @override
  List<Object?> get props => [id];
}
