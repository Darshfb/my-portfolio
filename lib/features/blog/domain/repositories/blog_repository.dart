import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/blog_post.dart';
import '../entities/comment.dart';

abstract class BlogRepository {
  Future<Either<Failure, List<BlogPost>>> getBlogPosts({int limit = 10, String? startAfterId});
  Future<Either<Failure, BlogPost>> getBlogPostById(String id);
  Future<Either<Failure, void>> createBlogPost(BlogPost post);
  Future<Either<Failure, void>> updateBlogPost(BlogPost post);
  Future<Either<Failure, void>> deleteBlogPost(String id);
  
  Future<Either<Failure, List<Comment>>> getComments(String postId);
  Future<Either<Failure, void>> addComment(Comment comment);
  Future<Either<Failure, void>> deleteComment(String commentId, String postId);
  
  Future<Either<Failure, void>> likePost(String postId);
}
