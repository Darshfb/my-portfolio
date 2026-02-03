import 'package:equatable/equatable.dart';
import '../../domain/entities/blog_post.dart';
import '../../domain/entities/comment.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object?> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogPostsLoaded extends BlogState {
  final List<BlogPost> posts;
  final bool hasMore;

  const BlogPostsLoaded({required this.posts, required this.hasMore});

  @override
  List<Object?> get props => [posts, hasMore];
}

class BlogPostLoaded extends BlogState {
  final BlogPost post;
  final List<Comment> comments;

  const BlogPostLoaded({required this.post, this.comments = const []});

  @override
  List<Object?> get props => [post, comments];
}

class BlogError extends BlogState {
  final String message;

  const BlogError(this.message);

  @override
  List<Object?> get props => [message];
}

class CommentAdded extends BlogState {}
class PostLiked extends BlogState {}
class BlogOperationSuccess extends BlogState {
  final String message;
  const BlogOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
