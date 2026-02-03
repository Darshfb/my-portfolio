import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/project.dart';
import '../../domain/usecases/get_projects_usecase.dart';
import '../../domain/usecases/add_project_usecase.dart';
import '../../domain/usecases/update_project_usecase.dart';
import '../../domain/usecases/delete_project_usecase.dart';

part 'projects_state.dart';

@injectable
class ProjectsCubit extends Cubit<ProjectsState> {
  final GetProjectsUseCase _getProjectsUseCase;
  final AddProjectUseCase _addProjectUseCase;
  final UpdateProjectUseCase _updateProjectUseCase;
  final DeleteProjectUseCase _deleteProjectUseCase;

  ProjectsCubit(
    this._getProjectsUseCase,
    this._addProjectUseCase,
    this._updateProjectUseCase,
    this._deleteProjectUseCase,
  ) : super(ProjectsInitial());

  ProjectType? _currentFilter;

  Future<void> fetchProjects() async {
    emit(ProjectsLoading());
    final result = await _getProjectsUseCase();
    result.fold(
      (failure) => emit(ProjectsError(failure.message)),
      (projects) => emit(ProjectsLoaded(projects, filter: _currentFilter)),
    );
  }

  void setFilter(ProjectType? filter) {
    _currentFilter = filter;
    if (state is ProjectsLoaded) {
      emit(ProjectsLoaded((state as ProjectsLoaded).projects, filter: filter));
    }
  }

  Future<void> addProject(Project project) async {
    emit(ProjectsLoading());
    final result = await _addProjectUseCase(project);
    result.fold(
      (failure) => emit(ProjectsError(failure.message)),
      (_) => fetchProjects(),
    );
  }

  Future<void> updateProject(Project project) async {
    emit(ProjectsLoading());
    final result = await _updateProjectUseCase(project);
    result.fold(
      (failure) => emit(ProjectsError(failure.message)),
      (_) => fetchProjects(),
    );
  }

  Future<void> deleteProject(String id) async {
    emit(ProjectsLoading());
    final result = await _deleteProjectUseCase(id);
    result.fold(
      (failure) => emit(ProjectsError(failure.message)),
      (_) => fetchProjects(),
    );
  }
}
