import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/blog_post.dart';
import '../repositories/blog_repository.dart';

@lazySingleton
class GetBlogPostByIdUseCase {
  final BlogRepository repository;

  GetBlogPostByIdUseCase(this.repository);

  Future<Either<Failure, BlogPost>> call(String id) {
    return repository.getBlogPostById(id);
  }
}
