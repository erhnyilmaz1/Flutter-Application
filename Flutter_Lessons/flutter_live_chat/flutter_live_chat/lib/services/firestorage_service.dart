// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_live_chat/services/firestorage_base.dart';

class FirestorageService implements FirestorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  late Reference _storageReference;
  @override
  Future<String> updateFile(
      String userId, String fileType, File downloadFile) async {
    _storageReference = _firebaseStorage
        .ref()
        .child(userId)
        .child(fileType)
        .child('profil_photo.png');
    var _uploadTask = _storageReference.putFile(downloadFile);

    var _url = '';

    _uploadTask.whenComplete(() => () async {
          _url = await _storageReference.getDownloadURL();
        });

    return _url;
  }
}
