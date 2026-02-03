import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../repositories/project_repository.dart';

@lazySingleton
class DeleteProjectUseCase {
  final ProjectRepository repository;

  DeleteProjectUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteProject(id);
  }
}
