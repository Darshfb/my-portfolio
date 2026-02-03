import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../repositories/blog_repository.dart';

@lazySingleton
class LikePostUseCase {
  final BlogRepository repository;

  LikePostUseCase(this.repository);

  Future<Either<Failure, void>> call(String postId) {
    return repository.likePost(postId);
  }
}
