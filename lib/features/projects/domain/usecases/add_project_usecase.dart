import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/project.dart';
import '../repositories/project_repository.dart';

@lazySingleton
class AddProjectUseCase {
  final ProjectRepository repository;

  AddProjectUseCase(this.repository);

  Future<Either<Failure, void>> call(Project project) {
    return repository.addProject(project);
  }
}
