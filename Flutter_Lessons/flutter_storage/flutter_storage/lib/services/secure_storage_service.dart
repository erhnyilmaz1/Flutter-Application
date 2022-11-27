import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/local_storage_service.dart';

class SecureStorageService implements LocalStorageService {
  late final FlutterSecureStorage preferences;  
  SecureStorageService() {
    debugPrint('Run SecureStorageService Structure.');
    preferences = const FlutterSecureStorage();
  }
  @override
  Future<void> saveData(UserInformation _userInformation) async {
    // SecureStorage KAYDETME(YAZDIRMA) İŞLEMİ
    // SecureStorage Write İşlemlerinden Önce await Yazılmalıdır.
    await preferences.write(key: "name", value: _userInformation.name);
    await preferences.write(
        key: "gender", value: _userInformation.gender.index.toString());
    await preferences.write(
        key: "color", value: jsonEncode(_userInformation.color).toString());
    await preferences.write(
        key: "isStudent", value: _userInformation.isStudent.toString());
  }
  @override
  Future<UserInformation> readData() async {
    // SecureStorage OKUMA İŞLEMİ
    // SecureStorage Read İşlemlerinden Önce await Yazılmalıdır.
    var name = await preferences.read(key: "name") ?? '';

    var genderString = await preferences.read(key: "gender") ?? '0';
    var gender = Gender.values[int.parse(genderString.toString())];

    var colorString = await preferences.read(key: "color");
    var color = colorString == null
        ? <String>[]
        : List<String>.from(jsonDecode(colorString));
    var studentString = await preferences.read(key: "isStudent") ?? "false";
    var isStudent = studentString.toLowerCase() == "true";
    return UserInformation(name, gender, color, isStudent);
  }
}
