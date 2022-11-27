// ignore_for_file: constant_identifier_names

import 'package:hive/hive.dart';
part 'student.g.dart';
// part 'student.g.dart' PAKETİ YAZILARAK "flutter packages pub run build_runner build" KOMUTU ÇALIŞTIRILDI VE student.g.dart DOSYASI OLUŞTURULDU. g:Generated

@HiveType(typeId: 1)
class Student {
  @HiveField(0, defaultValue: 1994)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final EyesColor eyeColor;

  Student({
    required this.id,
    required this.name,
    required this.eyeColor,
  });

  @override
  String toString() {
    return "$id - $name - $eyeColor";
  }
}

@HiveType(typeId: 2)
enum EyesColor {
  @HiveField(0, defaultValue: true)
  BLACK,

  @HiveField(1)
  BLUE,

  @HiveField(2)
  GREEN
}
