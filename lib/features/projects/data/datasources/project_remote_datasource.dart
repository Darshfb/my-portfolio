import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../models/project_model.dart';

abstract class ProjectDataSource {
  Future<List<ProjectModel>> getProjects();
  Future<void> addProject(ProjectModel project);
  Future<void> updateProject(ProjectModel project);
  Future<void> deleteProject(String id);
}

@LazySingleton(as: ProjectDataSource)
class ProjectDataSourceImpl implements ProjectDataSource {
  final FirebaseFirestore _firestore;
  static const String _collection = 'projects';

  ProjectDataSourceImpl(this._firestore);

  @override
  Future<List<ProjectModel>> getProjects() async {
    final snapshot = await _firestore.collection(_collection)
        .orderBy('orderIndex')
        .get();
    return snapshot.docs.map((doc) => ProjectModel.fromJson(doc.data()..['id'] = doc.id)).toList();
  }

  @override
  Future<void> addProject(ProjectModel project) async {
    await _firestore.collection(_collection).add(project.toJson());
  }

  @override
  Future<void> updateProject(ProjectModel project) async {
    await _firestore.collection(_collection).doc(project.id).update(project.toJson());
  }

  @override
  Future<void> deleteProject(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }
}
