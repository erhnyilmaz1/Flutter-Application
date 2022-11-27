// ignore_for_file: file_names, must_be_immutable, avoid_unnecessary_containers, avoid_printF, deprecated_member_use
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_note_basket/models/notes.dart';
import 'package:flutter_note_basket/utils/database_helper.dart';

import 'noteDetail.dart';

class AllNotes extends StatefulWidget {
  List<String> allNotePriority;

  AllNotes({Key? key, required this.allNotePriority}) : super(key: key);

  @override
  State<AllNotes> createState() => _AllNotesState();
}

class _AllNotesState extends State<AllNotes> {
  late DatabaseHelper _databaseHelper;
  late List<Notes> _allNotes;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _allNotes = [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _databaseHelper.selectedNotesList(),
      initialData: [Notes(0, '', '', '', 0)],
      builder: (context, AsyncSnapshot<List<Notes>> snapshot) {
        if ((snapshot.hasData) ||
            (snapshot.connectionState == ConnectionState.done)) {
          _allNotes = snapshot.data!;
          sleep(const Duration(milliseconds: 500));
          return ListView.builder(
              itemBuilder: (context, index) {
                Notes _selectedNote = _allNotes[index];
                return ExpansionTile(
                  leading: _priorityIcon(_selectedNote.notePriority),
                  title: Text(_selectedNote.noteName!),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Category',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _selectedNote.categoryName!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Theme.of(context).accentColor),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Created Date',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _databaseHelper.dateFormat(
                                      DateTime.parse(_selectedNote.noteDate!)),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Theme.of(context).accentColor),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                child: const Text(
                                  "Context",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 14),
                                child: Text(
                                  _selectedNote.noteContext!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.blueGrey),
                                ),
                              ),
                            ],
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                onPressed: () {
                                  _deleteNote(_selectedNote.noteId);
                                },
                                child: Text(
                                  'DELETE',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
                                onPressed: () {
                                  _updateNote(_selectedNote);
                                },
                                child: Text(
                                  'UPDATE',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
              itemCount: _allNotes.length);
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Text('LOADING...');
        }
      },
    );
  }

  _priorityIcon(int? notePriority) {
    return CircleAvatar(
      child: Text(
        widget.allNotePriority[notePriority!],
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.redAccent.shade100,
    );
  }

  void _deleteNote(int? noteId) {
    _databaseHelper.deleteNotes(noteId!).then((deleteNoteId) => {
          if (deleteNoteId != 0)
            {
              Scaffold.of(context)
                  .showBottomSheet<void>((BuildContext context) {
                return Container(
                  child: const SnackBar(
                    content: Text('Deleted Note'),
                    duration: Duration(seconds: 2),
                  ),
                );
              })
            }
        });
    setState(() {});
  }

  void _updateNote(Notes selectedNote) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NoteDetail(
              title: "Update Note",
              allNotePriority: widget.allNotePriority,
              notes: selectedNote,
            )));
  }
}
