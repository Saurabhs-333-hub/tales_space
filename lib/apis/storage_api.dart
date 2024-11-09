import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../appwrite_config/appwrite_config.dart';

final storageApiProvider = Provider((ref) {
  return StorageApi(storage: ref.watch(appwriteStorageProvider));
});

class StorageApi {
  final FirebaseStorage _storage;
  StorageApi({required FirebaseStorage storage}) : _storage = storage;
  Future<List<String>> uploadImage(List<File> files) async {
    List<String> imageLinks = [];
    for (var file in files) {
      final uploadImage =
          await _storage.ref('images/${file.path}').putFile(file);
      final imageUrl = await uploadImage.ref.getDownloadURL();
      imageLinks.add(imageUrl);
    }
    return imageLinks;
  }
}
