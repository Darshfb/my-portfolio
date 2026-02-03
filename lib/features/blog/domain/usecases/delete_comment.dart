import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../repositories/blog_repository.dart';

@lazySingleton
class DeleteCommentUseCase {
  final BlogRepository repository;

  DeleteCommentUseCase(this.repository);

  Future<Either<Failure, void>> call(String commentId, String postId) {
    return repository.deleteComment(commentId, postId);
  }
}
