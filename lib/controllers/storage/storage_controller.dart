import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

class StorageController {
  Future<String?> uploadImage(File file, {required String path}) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      final reference = FirebaseStorage.instance.ref("$path/$fileName");
      final uploadTask = reference.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
