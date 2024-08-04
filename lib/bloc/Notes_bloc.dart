

import 'package:bloc/bloc.dart';
import 'package:notes_app/Model/Notes_model.dart';
import 'package:notes_app/bloc/Notes_Event.dart';
import 'package:notes_app/bloc/Notes_state.dart';
import 'package:notes_app/database/db_helper.dart';

class NotesBloc extends Bloc<NotesEvent,NotesState>{
  db_helper DB_helper;
  NotesBloc({required this.DB_helper}) : super(NotesInitialState()){
    on<AddNotes>((events,emit)async{
      emit(NotesLoadingState());
      bool check = await DB_helper.addNotes(events.NoteModel);
      if(check){
        var arrnotes = await DB_helper.fetchAllNotes();
        emit(NotesLoadedState(arrnotes: arrnotes));
      }
    });

    on<Fetchdata>((event, emit) async{
      emit(NotesLoadingState());
      var arrnotes=await DB_helper.fetchAllNotes();
      emit(NotesLoadedState(arrnotes: arrnotes));
    });
    on<NotesUpdate>((event, emit) async{
      emit(NotesLoadingState());
      bool check = await DB_helper.updateNotes(noteModel(title: event.title,desc: event.desc,note_id: event.id));
      if(check)
      {
        var arrnotes=await DB_helper.fetchAllNotes();
        emit(NotesLoadedState(arrnotes: arrnotes));
      }
    });
    on<NotesDelete>((event, emit) async{
      emit(NotesLoadingState());
      bool check = await DB_helper.deleteNotes(event.id);
      if(check)
      {
        var arrnotes=await DB_helper.fetchAllNotes();
        emit(NotesLoadedState(arrnotes: arrnotes));
      }
    });
  }
}