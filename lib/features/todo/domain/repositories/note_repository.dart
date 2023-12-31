import 'package:creiden/features/todo/domain/entities/note_model.dart';
import 'package:creiden/features/todo/domain/usecases/add_note.dart';
import 'package:creiden/features/todo/domain/usecases/delete_note.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<NoteModel>>> getAllNotes();

  Future<Either<Failure, NoteModel>> addNote({required AddNoteParams params});

  Future<Either<Failure, Unit>> updateNote({required AddNoteParams params});

  Future<Either<Failure, Unit>> deleteNote({required DeleteNoteParams params});
}
