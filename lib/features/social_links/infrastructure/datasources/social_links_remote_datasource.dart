
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../models/social_link_model.dart';
import '../../domain/entities/social_link.dart';

@lazySingleton
class SocialLinksRemoteDatasource {
  final FirebaseFirestore _firestore;

  SocialLinksRemoteDatasource(this._firestore);

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('social_links');

  Future<List<SocialLinkModel>> getSocialLinks() async {
    final snapshot = await _collection.get();
    return snapshot.docs
        .map((doc) => SocialLinkModel.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  Future<void> addSocialLink(SocialLinkModel model) async {
    await _collection.doc(model.id.isEmpty ? null : model.id).set(model.toJson());
  }

  Future<void> updateSocialLink(SocialLinkModel model) async {
    await _collection.doc(model.id).update(model.toJson());
  }

  Future<void> deleteSocialLink(String id) async {
    await _collection.doc(id).delete();
  }
}
