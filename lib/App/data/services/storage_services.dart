import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StorageServices {
  final storage = FirebaseStorage.instance;

  Future<String> uploadFileToStorage(File file, String path) async {
    try {
      final storageRef = storage.ref().child(path);
      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }
}

final storageServiceProvider = Provider((ref) => StorageServices());
