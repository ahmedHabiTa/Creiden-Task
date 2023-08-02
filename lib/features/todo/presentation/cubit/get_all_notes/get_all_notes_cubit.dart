import 'package:bloc/bloc.dart';
import 'package:creiden/features/core/usecases/usecases.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../domain/entities/note_model.dart';
import '../../../domain/usecases/get_all_notes.dart';

part 'get_all_notes_state.dart';

class GetAllNotesCubit extends Cubit<GetAllNotesState> {
  GetAllNotesCubit({required this.getAllNotesUsecase})
      : super(GetAllNotesInitial());

  final GetAllNotesUsecase getAllNotesUsecase;

  List<NoteModel> _noteList = [];
  List<NoteModel> get noteList => _noteList;

  Future<void> fReadAllNotes() async {
    emit(GetAllNotesLoading());
    final failOrUser = await getAllNotesUsecase(NoParams());
    failOrUser.fold((fail) {
      if (fail is NoteFailure) {
        emit(GetAllNotesError(message: fail.message));
      }
    }, (allNotesResponse) {
      _noteList = allNotesResponse;

      emit(GetAllNotesSuccess());
    });
  }
}
