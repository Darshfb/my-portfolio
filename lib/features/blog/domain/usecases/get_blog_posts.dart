import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/blog_post.dart';
import '../repositories/blog_repository.dart';

@lazySingleton
class GetBlogPostsUseCase {
  final BlogRepository repository;

  GetBlogPostsUseCase(this.repository);

  Future<Either<Failure, List<BlogPost>>> call({int limit = 10, String? startAfterId}) {
    return repository.getBlogPosts(limit: limit, startAfterId: startAfterId);
  }
}
