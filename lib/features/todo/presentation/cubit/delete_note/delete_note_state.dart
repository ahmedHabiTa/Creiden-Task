part of 'delete_note_cubit.dart';

abstract class DeleteNoteState extends Equatable {
  const DeleteNoteState();

  @override
  List<Object> get props => [];
}

class DeleteNoteInitial extends DeleteNoteState {}

class DeleteNoteLoading extends DeleteNoteState {}

class DeleteNoteError extends DeleteNoteState {
  final String message;
  const DeleteNoteError({required this.message});
}

class DeleteNoteSuccess extends DeleteNoteState {}
