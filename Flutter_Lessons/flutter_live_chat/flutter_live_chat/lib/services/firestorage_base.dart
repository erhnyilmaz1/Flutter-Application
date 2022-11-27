import 'dart:io';

abstract class FirestorageBase {
  Future<String> updateFile(String userId, String fileType, File downloadFile);
}
