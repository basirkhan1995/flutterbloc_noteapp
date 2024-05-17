part of 'note_bloc.dart';

sealed class NoteState extends Equatable {
  const NoteState();
}

final class NoteInitial extends NoteState {
  @override
  List<Object> get props => [];
}

//Loading State
final class LoadingState extends NoteState{
  @override
  List<Object> get props => [];
}

//Get All Notes
final class LoadedState extends NoteState{
  final List<Notes> allNotes;
  const LoadedState(this.allNotes);
  @override
  List<Object> get props => [allNotes];
}

//In case when there is an error
final class FailureState extends NoteState{
  final String errorMessage;
  const FailureState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

//Get Note by ID
final class GetNoteByIdState extends NoteState{
  final Notes notes;
  const GetNoteByIdState(this.notes);
  @override
  List<Object?> get props => [notes];
}

//Success Note Add Insertion
final class SuccessNoteInsertion extends NoteState{
  @override
  List<Object?> get props => [];

}
final class SuccessNoteUpdate extends NoteState{
  @override
  List<Object?> get props => [];

}
final class SuccessNoteDelete extends NoteState{
  @override
  List<Object?> get props => [];

}

