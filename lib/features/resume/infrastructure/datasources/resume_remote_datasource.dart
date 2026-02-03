
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import '../models/resume_metadata_model.dart';
import '../../domain/entities/resume_metadata.dart';
import 'dart:typed_data';

@lazySingleton
class ResumeRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ResumeRemoteDatasource(this._firestore, this._storage);

  DocumentReference<Map<String, dynamic>> get _metadataDoc =>
      _firestore.collection('settings').doc('resume');

  Future<ResumeMetadataModel?> getResumeMetadata() async {
    final doc = await _metadataDoc.get();
    if (!doc.exists) return null;
    return ResumeMetadataModel.fromJson(doc.data()!);
  }

  Future<void> updateResumeMetadata(ResumeMetadataModel model) async {
    await _metadataDoc.set(model.toJson());
  }

  Future<String> uploadCV(Uint8List bytes, String fileName) async {
    final ref = _storage.ref().child('resumes/$fileName');
    final uploadTask = await ref.putData(
      bytes,
      SettableMetadata(contentType: 'application/pdf'),
    );
    return await uploadTask.ref.getDownloadURL();
  }
}
