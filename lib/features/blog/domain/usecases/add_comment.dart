import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/comment.dart';
import '../repositories/blog_repository.dart';

@lazySingleton
class AddCommentUseCase {
  final BlogRepository repository;

  AddCommentUseCase(this.repository);

  Future<Either<Failure, void>> call(Comment comment) {
    return repository.addComment(comment);
  }
}
