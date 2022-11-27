// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:flutter/foundation.dart';

enum Gender { MALE, FEMALE, OTHER }
enum Color { YELLOW, RED, BLUE, GREEN }

class UserInformation {
  String name;
  Gender gender;
  List<String> color;
  bool isStudent;

  UserInformation(
    this.name,
    this.gender,
    this.color,
    this.isStudent,
  );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "gender": describeEnum(gender),
      "color": color,
      "isStudent": isStudent,
    };
  }

  UserInformation.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        gender = Gender.values.firstWhere( (element) =>
        describeEnum(element).toString() == json['gender']),
        color = List<String>.from(json['color']),
        isStudent = json['isStudent'];
}
