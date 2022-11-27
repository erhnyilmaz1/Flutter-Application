// ignore_for_file: file_names, unused_local_variable, avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_note_basket/models/category.dart';
import 'package:flutter_note_basket/utils/database_helper.dart';
import 'package:flutter_note_basket/widgets/allNotes.dart';
import 'package:flutter_note_basket/widgets/categoryList.dart';
import 'package:flutter_note_basket/widgets/noteDetail.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static late List<String> _allNotePriority;

  @override
  void initState() {
    super.initState();
    _allNotePriority = ["LOW", "MIDDLE", "HIGH"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: const Center(
          child: Text(
            'Note Basket',
            style:
                TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    child: ListTile(
                        leading: const Icon(
                          Icons.import_contacts,
                          color: Colors.orange,
                        ),
                        title: const Text(
                          "Categories",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w700),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CategoryList()));
                        }))
              ];
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _addCategory(context);
            },
            child: const Icon(
              Icons.import_contacts,
              color: Colors.white,
            ),
            tooltip: 'Add Category',
            heroTag:
                "AddCategory", // 2 Floating Butonu Birbirinden Ayırmak İçin Kullanılır.
            mini: true,
          ),
          FloatingActionButton(
            onPressed: () {
              _addNote(context);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            tooltip: 'Add Note',
            heroTag:
                "AddNote", // 2 Floating Butonu Birbirinden Ayırmak İçin Kullanılır.
          ),
        ],
      ),
      body: AllNotes(
        allNotePriority: _allNotePriority,
      ),
    );
  }

  Future<dynamic> _addCategory(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    String? newCategoryName;

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              'Add Category',
              style: TextStyle(
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey),
            ),
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Category Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (categoryValue) {
                      if (categoryValue!.length < 3) {
                        return "You Have To Enter Least 3 Characters.";
                      }
                    },
                    onSaved: (categoryValue) {
                      newCategoryName = categoryValue!;
                    },
                  ),
                ),
              ),
              ButtonBar(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        _databaseHelper
                            .createCategory(Category(newCategoryName))
                            .then((categoryId) {
                          if (categoryId > 0) {
                            _scaffoldKey.currentState!
                                .showBottomSheet<void>((BuildContext context) {
                              return Container(
                                child: const SnackBar(
                                  content: Text('Added Category'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            });
                            Navigator.of(context).pop();
                          }
                        });
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  void _addNote(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NoteDetail(
              title: "New Note",
              allNotePriority: _allNotePriority,
            )));
  }
}
