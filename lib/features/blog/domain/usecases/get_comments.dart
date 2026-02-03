import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/comment.dart';
import '../repositories/blog_repository.dart';

@lazySingleton
class GetCommentsUseCase {
  final BlogRepository repository;

  GetCommentsUseCase(this.repository);

  Future<Either<Failure, List<Comment>>> call(String postId) {
    return repository.getComments(postId);
  }
}
