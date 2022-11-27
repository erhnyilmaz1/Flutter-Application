import 'package:flutter/material.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements LocalStorageService {
  late final SharedPreferences preferences;

  SharedPreferencesService() {
    init();
  }

  Future<void> init() async {
    debugPrint('Run SharedPreferencesService Structure.');
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveData(UserInformation _userInformation) async {
    // SharedPreferences KAYDETME(YAZDIRMA) İŞLEMİ

    preferences.setString("name", _userInformation.name);
    preferences.setInt("gender", _userInformation.gender.index);
    preferences.setStringList("color", _userInformation.color);
    preferences.setBool("isStudent", _userInformation.isStudent);
  }

  @override
  Future<UserInformation> readData() async {
    // SharedPreferences OKUMA İŞLEMİ

    var name = preferences.getString("name") ?? '';
    var gender = Gender.values[preferences.getInt("gender") ?? 2];
    var color = preferences.getStringList("color") ?? [];
    var isStudent = preferences.getBool("isStudent") ?? false;

    return UserInformation(name, gender, color, isStudent);
  }
}
