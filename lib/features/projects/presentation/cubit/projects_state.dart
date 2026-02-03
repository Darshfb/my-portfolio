part of 'projects_cubit.dart';

abstract class ProjectsState extends Equatable {
  const ProjectsState();

  @override
  List<Object?> get props => [];
}

class ProjectsInitial extends ProjectsState {}

class ProjectsLoading extends ProjectsState {}

class ProjectsLoaded extends ProjectsState {
  final List<Project> projects;
  final ProjectType? filter;

  const ProjectsLoaded(this.projects, {this.filter});

  List<Project> get filteredProjects {
    var sorted = List<Project>.from(projects)..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    if (filter == null) return sorted;
    return sorted.where((p) => p.type == filter).toList();
  }

  @override
  List<Object?> get props => [projects, filter];
}

class ProjectsError extends ProjectsState {
  final String message;
  const ProjectsError(this.message);

  @override
  List<Object?> get props => [message];
}
