import 'package:creiden/core/widgets/show_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../injection_container.dart';
import '../../../domain/usecases/delete_note.dart';
import '../get_all_notes/get_all_notes_cubit.dart';

part 'delete_note_state.dart';

class DeleteNoteCubit extends Cubit<DeleteNoteState> {
  DeleteNoteCubit({required this.deleteNoteUsecase})
      : super(DeleteNoteInitial());

  final DeleteNoteUsecase deleteNoteUsecase;

  Future<void> fDeleteNote(
      {required int id, required BuildContext context}) async {
    emit(DeleteNoteLoading());
    final failOrUser = await deleteNoteUsecase(DeleteNoteParams(id: id));
    failOrUser.fold((fail) {
      if (fail is NoteFailure) {
        emit(DeleteNoteError(message: fail.message));
      }
    }, (allNotesResponse) {
      sl<GetAllNotesCubit>().fReadAllNotes(context);
      showToastSuccess('Note Deleted Successfully');
      emit(DeleteNoteSuccess());
    });
  }
}
