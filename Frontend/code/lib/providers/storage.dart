import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<Map<String, dynamic>>> listFiles(String path) async {
    List<Map<String, dynamic>> files = [];

    // Reference to the directory you want to list files from
    final ListResult result = await storage.ref(path).listAll();

    for (var file in result.items) {
      final String downloadUrl = await file.getDownloadURL();
      final FullMetadata metadata = await file.getMetadata();

      files.add({
        'url': downloadUrl,
        'path': file.fullPath,
        'size': metadata.size,
        'name': file.name,
      });
    }

    return files;
  }
}

