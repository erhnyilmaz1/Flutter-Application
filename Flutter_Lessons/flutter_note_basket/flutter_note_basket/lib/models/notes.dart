// ignore_for_file: prefer_collection_literals, unnecessary_this

class Notes {
  int? noteId;
  int? categoryId;
  String? categoryName;
  String? noteName;
  String? noteContext;
  String? noteDate;
  int? notePriority;

  Notes(this.categoryId, this.noteName, this.noteContext, this.noteDate,
      this.notePriority);
  Notes.withID(this.noteId, this.categoryId, this.noteName, this.noteContext,
      this.noteDate, this.notePriority);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["noteId"] = noteId;
    map["categoryId"] = categoryId;
    map["noteName"] = noteName;
    map["noteContext"] = noteContext;
    map["noteDate"] = noteDate;
    map["notePriority"] = notePriority;
    return map;
  }

  Notes.fromMap(Map<String, dynamic> map) {
    this.noteId = map["noteId"];
    this.categoryId = map["categoryId"];
    this.categoryName = map["categoryName"];
    this.noteName = map["noteName"];
    this.noteContext = map["noteContext"];
    this.noteDate = map["noteDate"];
    this.notePriority = map["notePriorityv"];
  }

  @override
  String toString() {
    return "Notes{noteId: $noteId , categoryId: $categoryId, noteName: $noteName , noteContext: $noteContext, noteDate: $noteDate , notePriority: $notePriority}";
  }
}
