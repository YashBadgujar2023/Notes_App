

import 'package:notes_app/database/db_helper.dart';

class noteModel {
  int? note_id;
  String? title;
  String? desc;

  noteModel({ this.note_id,  this.title,  this.desc});

  //factory func = model to map
  factory noteModel.fromMap(Map<String, dynamic> map) {
    return noteModel(
      note_id: map[db_helper.Note_COLUMN_ID],
      title: map[db_helper.Note_COLUMN_TITLE],
      desc: map[db_helper.Note_COLUMN_DESC],
    );
  }

  //map data from note model
  Map<String, dynamic> toMap() {
    return {
      db_helper.Note_COLUMN_ID: note_id,
      db_helper.Note_COLUMN_TITLE: title,
      db_helper.Note_COLUMN_DESC: desc
    };
  }
}