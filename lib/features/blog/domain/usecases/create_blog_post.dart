import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/blog_post.dart';
import '../repositories/blog_repository.dart';

@lazySingleton
class CreateBlogPostUseCase {
  final BlogRepository repository;

  CreateBlogPostUseCase(this.repository);

  Future<Either<Failure, void>> call(BlogPost post) {
    return repository.createBlogPost(post);
  }
}
