part of 'add_note_cubit.dart';

abstract class AddNoteState extends Equatable {
  const AddNoteState();

  @override
  List<Object> get props => [];
}

class AddNoteInitial extends AddNoteState {}

class ChangeAddNoteState extends AddNoteState {}

class AddNoteSuccess extends AddNoteState {}

class AddNoteLoading extends AddNoteState {}

class AddNoteError extends AddNoteState {
  final String message;
  const AddNoteError({required this.message});
}
