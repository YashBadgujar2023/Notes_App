import 'package:notes_app/Model/Notes_model.dart';

abstract class NotesEvent{}
class AddNotes extends NotesEvent{
  noteModel NoteModel;
  AddNotes({required this.NoteModel});
}
class Fetchdata extends NotesEvent{}

class NotesUpdate extends NotesEvent{
  int id;
  String title;
  String desc;
  NotesUpdate({required this.id,required this.title,required this.desc});
}

class NotesDelete extends NotesEvent{
  int id;
  NotesDelete({required this.id});
}