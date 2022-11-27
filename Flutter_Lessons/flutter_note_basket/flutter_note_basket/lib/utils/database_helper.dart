// ignore_for_file: avoid_print, unused_element, unused_local_variable, unused_field
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_note_basket/models/category.dart';
import 'package:flutter_note_basket/models/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:typed_data';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  factory DatabaseHelper() {
    return _databaseHelper = DatabaseHelper._internal();
  }
  DatabaseHelper._internal();
  static Database? _database;
  Future<Database> _getDatabase() async {
    Database? instance = _database;
    if (instance == null) {
      instance = await _initializeDatabase();
      return instance;
    } else {
      return instance;
    }
  }

  Future<Database> _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "applicationNotes.db");

    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "notes.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    return await openDatabase(path,
        readOnly:
            false); // true ise Sadece Select Yapılır. Insert, Update,Select Yapılmaz.
  }

  Future<List<Map<String, dynamic>>> selectedCategoryMap() async {
    var db = await _getDatabase();
    var result = db.query("category");
    return result;
  }

  Future<List<Category>> selectedCategoryList() async {
    print("ALL CATEGORY LIST START");
    List<Category> _allCategory = [];
    List<Map<String, dynamic>> selectedCategoryMap =
        await this.selectedCategoryMap();

    for (Map<String, dynamic> itemMap in selectedCategoryMap) {
      _allCategory.add(Category.fromMap(itemMap));
    }
    print("ALL CATEGORY LIST: " + _allCategory.toString());
    return _allCategory;
  }

  Future<int> createCategory(Category category) async {
    print("CREATE CATEGORY ITEM: " + category.toMap().toString());
    var db = await _getDatabase();
    var result = db.insert("category", category.toMap());
    return result;
  }

  Future<int> updateCategory(Category category) async {
    var db = await _getDatabase();
    var result = db.update("category", category.toMap(),
        where: 'categoryId = ? ', whereArgs: [category.categoryId]);
    return result;
  }

  Future<int> deleteCategory(int categoryId) async {
    var db = await _getDatabase();
    var result = db
        .delete("category", where: 'categoryId = ? ', whereArgs: [categoryId]);
    return result;
  }

  Future<List<Map<String, dynamic>>> selectedNotesMap() async {
    var db = await _getDatabase();
    // var result = db.query("note", orderBy: 'noteId DESC');
    var result = db.rawQuery(
        'SELECT * FROM CATEGORY INNER JOIN NOTE ON CATEGORY.CATEGORYID = NOTE.CATEGORYID ORDER BY NOTEID DESC'); // JOIN YAPISINI KULLANMAK İÇİN QUERY YERİNE RAW QUERY YAPILDI.
    return result;
  }

  Future<List<Notes>> selectedNotesList() async {
    print("ALL NOTES LIST START");
    List<Notes> _allNotes = [];
    List<Map<String, dynamic>> selectedNotesMap = await this.selectedNotesMap();

    for (Map<String, dynamic> itemMap in selectedNotesMap) {
      _allNotes.add(Notes.fromMap(itemMap));
    }
    print("ALL NOTES LIST: " + _allNotes.toString());
    return _allNotes;
  }

  Future<int> createNotes(Notes notes) async {
    var db = await _getDatabase();
    var result = db.insert("note", notes.toMap());
    return result;
  }

  Future<int> updateNotes(Notes notes) async {
    var db = await _getDatabase();
    var result = db.update("note", notes.toMap(),
        where: 'noteId = ? ', whereArgs: [notes.categoryId]);
    return result;
  }

  Future<int> deleteNotes(int categoryId) async {
    var db = await _getDatabase();
    var result =
        db.delete("note", where: 'noteId = ? ', whereArgs: [categoryId]);
    return result;
  }

  String dateFormat(DateTime tm) {
    DateTime today = DateTime.now();
    Duration oneDay = const Duration(days: 1);
    Duration twoDays = const Duration(days: 2);
    Duration oneWeek = const Duration(days: 7);
    late String month;
    switch (tm.month) {
      case 1:
        month = "January";
        break;
      case 2:
        month = "February";
        break;
      case 3:
        month = "March";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "August";
        break;
      case 9:
        month = "Semprember";
        break;
      case 10:
        month = "October";
        break;
      case 11:
        month = "November";
        break;
      case 12:
        month = "December";
        break;
    }
    Duration difference = today.difference(tm);

    if (difference.compareTo(oneDay) < 1) {
      return "today";
    } else if (difference.compareTo(twoDays) < 1) {
      return "yesterday";
    } else if (difference.compareTo(oneWeek) < 1) {
      switch (tm.weekday) {
        case 1:
          return "Monday";
        case 2:
          return "Tuesday";
        case 3:
          return "Wednesday";
        case 4:
          return "Thursday";
        case 5:
          return "Friday";
        case 6:
          return "Saturday";
        case 7:
          return "Sunday";
      }
    } else if (tm.year == today.year) {
      return '${tm.day} $month';
    } else {
      return '${tm.day} $month ${tm.year}';
    }
    return "";
  }
}
