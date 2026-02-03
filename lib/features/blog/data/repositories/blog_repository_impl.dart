import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/blog_post.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/blog_repository.dart';
import '../datasources/blog_remote_data_source.dart';
import '../models/blog_post_model.dart';
import '../models/comment_model.dart';

@LazySingleton(as: BlogRepository)
class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;

  BlogRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<BlogPost>>> getBlogPosts({
    int limit = 10,
    String? startAfterId,
  }) async {
    try {
      final posts = await remoteDataSource.getBlogPosts(
        limit: limit,
        startAfterId: startAfterId,
      );
      return Right(posts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BlogPost>> getBlogPostById(String id) async {
    try {
      final post = await remoteDataSource.getBlogPostById(id);
      return Right(post);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createBlogPost(BlogPost post) async {
    try {
      final model = BlogPostModel(
        id: post.id,
        title: post.title,
        summary: post.summary,
        content: post.content,
        author: post.author,
        publishDate: post.publishDate,
        imageUrl: post.imageUrl,
        tags: post.tags,
        likeCount: post.likeCount,
        commentCount: post.commentCount,
        language: post.language,
      );
      await remoteDataSource.createBlogPost(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateBlogPost(BlogPost post) async {
    try {
      final model = BlogPostModel(
        id: post.id,
        title: post.title,
        summary: post.summary,
        content: post.content,
        author: post.author,
        publishDate: post.publishDate,
        imageUrl: post.imageUrl,
        tags: post.tags,
        likeCount: post.likeCount,
        commentCount: post.commentCount,
        language: post.language,
      );
      await remoteDataSource.updateBlogPost(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBlogPost(String id) async {
    try {
      await remoteDataSource.deleteBlogPost(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getComments(String postId) async {
    try {
      final comments = await remoteDataSource.getComments(postId);
      return Right(comments);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addComment(Comment comment) async {
    try {
      final model = CommentModel(
        id: comment.id,
        postId: comment.postId,
        username: comment.username,
        text: comment.text,
        timestamp: comment.timestamp,
      );
      await remoteDataSource.addComment(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteComment(
    String commentId,
    String postId,
  ) async {
    try {
      await remoteDataSource.deleteComment(commentId, postId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likePost(String postId) async {
    try {
      await remoteDataSource.likePost(postId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
