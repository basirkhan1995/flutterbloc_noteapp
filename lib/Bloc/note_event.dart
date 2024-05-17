part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();
}
//Get Event
class GetAllNoteEvent extends NoteEvent{
  @override
  List<Object> get props => [];
}

//Add Note Event
 class AddNoteEvent extends NoteEvent{
   final Notes notes;
   const AddNoteEvent(this.notes);
   @override
   List<Object> get props => [notes];
 }

 //Update Note Event
class UpdateNoteEvent extends NoteEvent{
  final Notes notes;
   const UpdateNoteEvent(this.notes);
   @override
   List<Object> get props => [notes];
 }

 //Delete Note Event
class DeleteNoteEvent extends NoteEvent{
  final int id;
  const DeleteNoteEvent(this.id);
  @override
  List<Object> get props => [id];
}

//Get Note By ID
class GetNoteByIdEvent extends NoteEvent{
  final int id;
  const GetNoteByIdEvent(this.id);
  @override
  List<Object> get props => [id];
}

