import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/local_storage_service.dart';
import 'package:path_provider/path_provider.dart';

class PathProviderService implements LocalStorageService {

late final FlutterSecureStorage preferences;
  PathProviderService() {
    _createFile();
  }
  _getFilePath() async {
    var filePath = await getApplicationDocumentsDirectory();
    debugPrint(filePath.path);
    return filePath.path;
  }
  Future<File> _createFile() async {
    var file = File(await _getFilePath() + "/info.json");
    return file;
  }
  @override
  Future<void> saveData(UserInformation _userInformation) async {
    var file = await _createFile();
    file.writeAsStringSync(jsonEncode(_userInformation.toJson()));
  }
  @override
  Future<UserInformation> readData() async {
    try {
      var file = await _createFile();
      var decode = jsonDecode(await file.readAsString());
      return UserInformation.fromJson(decode);
    } catch (e) {
      debugPrint(e.toString());
    }
    return UserInformation('', Gender.MALE, [], false);
  }
}
