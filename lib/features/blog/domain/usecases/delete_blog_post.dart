import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../repositories/blog_repository.dart';

@lazySingleton
class DeleteBlogPostUseCase {
  final BlogRepository repository;

  DeleteBlogPostUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteBlogPost(id);
  }
}
