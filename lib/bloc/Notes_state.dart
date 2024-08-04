
import 'package:notes_app/Model/Notes_model.dart';

abstract class NotesState{}
class NotesInitialState extends NotesState{}
class NotesLoadingState extends NotesState{}
class NotesLoadedState extends NotesState{
  List<noteModel> arrnotes;
  NotesLoadedState({required this.arrnotes});
}
class NotesError extends NotesState{}