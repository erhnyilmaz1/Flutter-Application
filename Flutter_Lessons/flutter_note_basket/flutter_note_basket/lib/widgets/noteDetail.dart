// ignore_for_file: file_names, must_be_immutable, avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_note_basket/models/category.dart';
import 'package:flutter_note_basket/models/notes.dart';
import 'package:flutter_note_basket/utils/database_helper.dart';

class NoteDetail extends StatefulWidget {
  List<String> allNotePriority;
  String title;
  Notes? notes;

  NoteDetail(
      {Key? key,
      required this.title,
      required this.allNotePriority,
      this.notes})
      : super(key: key);

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  var formKey = GlobalKey<FormState>();
  late List<Category> _allCategories;
  static late List<String> _allNotePriority;
  late DatabaseHelper _databaseHelper;
  late String _noteName;
  late String _noteContext;
  late int _selectedCategoryId;
  late int _selectedNotePriority;
  late Category _selectedCategory;

  @override
  void initState() {
    super.initState();
    _allCategories = [];
    _allNotePriority = ["LOW", "MIDDLE", "HIGH"];
    _databaseHelper = DatabaseHelper();
    _databaseHelper.selectedCategoryMap().then((categoryList) => {
          for (Map<String, dynamic> itemMap in categoryList)
            {_allCategories.add(Category.fromMap(itemMap))}
        });

    if (widget.notes != null) {
      _selectedCategoryId = widget.notes!.categoryId!;
      _selectedNotePriority = widget.notes!.notePriority!;
    } else {
      _selectedCategoryId = 1;
      _selectedNotePriority = 0;
      _selectedCategory = _allCategories[0];
      debugPrint("Value Assigned To Selected Category: " +
          _selectedCategory.categoryName!);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var tag = const TextStyle(
        fontWeight: FontWeight.w700, fontSize: 20, color: Colors.blueGrey);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _allCategories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Category: ',
                            style: tag,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 1),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Category>(
                              items: showCategories(),
                              hint: const Text("Choose Category"),
                              value: _selectedCategory,
                              onChanged: (Category? _changedCategory) {
                                setState(() {
                                  _selectedCategory = _changedCategory!;
                                  _selectedCategoryId =
                                      _changedCategory.categoryId!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue:
                            widget.notes != null ? widget.notes!.noteName : "",
                        decoration: const InputDecoration(
                          hintText: 'Enter Note Name',
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (noteName) {
                          if (noteName!.length < 3) {
                            return "You Have To Enter Least 3 Characters";
                          }
                        },
                        onSaved: (newNoteName) {
                          _noteName = newNoteName!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 4,
                        initialValue: widget.notes != null
                            ? widget.notes!.noteContext
                            : "",
                        decoration: const InputDecoration(
                          hintText: 'Enter Note Context',
                          labelText: 'Context',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (newContext) {
                          _noteContext = newContext!;
                        },
                        // Veritabanında NOT NULL OLMADIĞIN İÇİN YANİ NULL Değer Geleceği İçin validator YAPILMADI.
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Priority: ',
                            style: tag,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              items: showPriority(),
                              value: _selectedNotePriority,
                              onChanged: (changedPriorityId) {
                                setState(() {
                                  _selectedNotePriority = changedPriorityId!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.grey),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent.shade700),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              var currentDate = DateTime.now();
                              if (widget.notes == null) {
                                _databaseHelper
                                    .createNotes(Notes(
                                        _selectedCategoryId,
                                        _noteName,
                                        _noteContext,
                                        '',
                                        _selectedNotePriority))
                                    .then((savedNoteId) => {
                                          if (savedNoteId != 0)
                                            {Navigator.of(context).pop()}
                                        });
                              } else {
                                _databaseHelper
                                    .updateNotes(Notes.withID(
                                        widget.notes!.noteId,
                                        _selectedCategoryId,
                                        _noteName,
                                        _noteContext,
                                        _databaseHelper.dateFormat(currentDate),
                                        _selectedNotePriority))
                                    .then((updatedNoteId) => {
                                          if (updatedNoteId != 0)
                                            {Navigator.of(context).pop()}
                                        });
                              }
                            }
                          },
                          child: const Text('Save',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }

  List<DropdownMenuItem<Category>> showCategories() {
    return _allCategories.map((category) {
      return DropdownMenuItem<Category>(
        child: Text(
          category.categoryName!,
          style: const TextStyle(fontSize: 16),
        ),
        value: category,
      );
    }).toList();
  }

  List<DropdownMenuItem<int>> showPriority() {
    return _allNotePriority
        .map(
          (priority) => DropdownMenuItem<int>(
            child: Text(
              priority,
              style: const TextStyle(fontSize: 16),
            ),
            value: _allNotePriority.indexOf(priority),
          ),
        )
        .toList();
  }
}
