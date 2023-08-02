part of 'get_all_notes_cubit.dart';

abstract class GetAllNotesState extends Equatable {
  const GetAllNotesState();

  @override
  List<Object> get props => [];
}

class GetAllNotesInitial extends GetAllNotesState {}

class GetAllNotesLoading extends GetAllNotesState {}

class GetAllNotesSuccess extends GetAllNotesState {}

class GetAllNotesError extends GetAllNotesState {
  final String message;
  const GetAllNotesError({required this.message});
}
