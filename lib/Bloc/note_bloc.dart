import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../DatabaseHelper/repository.dart';
import '../Models/notes.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final Repository repository;
  NoteBloc(this.repository) : super(NoteInitial()) {

    //Event controllers

    //GET ALL NOTE EVENT
    on<GetAllNoteEvent>((event, emit) async{
      emit(LoadingState());
      try{
         final notes = await repository.getNotes();
         emit(LoadedState(notes));
      }catch(e){
        emit(FailureState(e.toString()));
      }

    });

    //Add Note Event [ON ADD BUTTON]
    on<AddNoteEvent>((event, emit)async{
      emit(LoadingState());
      try{
        //1 sec delay
        Future.delayed(const Duration(seconds: 1));
        int res = await repository.addNote(Notes(
            title: event.notes.title,
            content: event.notes.content,
            createdAt: event.notes.createdAt));

        if(res>0){
          emit(SuccessNoteInsertion());
          //Call Fetch Note Event, once there is a new note
          add(GetAllNoteEvent());
        }
      }catch(e){
        emit(FailureState(e.toString()));
      }
    });

    //Get Note By Id [On a Single Note Click] - Let you to Get a Note by ID
    on<GetNoteByIdEvent>((event, emit)async{
      final notes = await repository.getNoteById(event.id);
      emit(GetNoteByIdState(notes));
    });

    //Update Note Event - When [ON UPDATE BUTTON] is Pressed
    on<UpdateNoteEvent>((event, emit)async{
      try{
       final notes = await repository.updateNote(Notes(
           noteId: event.notes.noteId,
           title: event.notes.title,
           content: event.notes.content,
           createdAt: event.notes.createdAt));

          if(notes> 0){
            emit(SuccessNoteUpdate());
            add(GetAllNoteEvent());
          }
      }catch(e){
        emit(FailureState(e.toString()));
      }

    });

    //Delete Note Event - When [ON Delete BUTTON] is Pressed
    on<DeleteNoteEvent>((event,emit)async{
      try{
       final res = await repository.deleteNote(event.id);
       if(res>0){
         emit(SuccessNoteDelete());
         add(GetAllNoteEvent());
       }
      }catch(e){
        emit(FailureState(e.toString()));
      }

    });
  }
}
