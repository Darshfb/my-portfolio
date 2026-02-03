import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

@lazySingleton
class ImageUploadService {
  final FirebaseStorage _storage;
  final ImagePicker _picker = ImagePicker();

  ImageUploadService(this._storage);

  Future<String?> uploadProjectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final Reference ref = _storage.ref().child('projects/$fileName');

    if (kIsWeb) {
      final Uint8List bytes = await image.readAsBytes();
      await ref.putData(bytes, SettableMetadata(contentType: 'image/jpeg'));
    } else {
      await ref.putFile(File(image.path));
    }

    return await ref.getDownloadURL();
  }
}
