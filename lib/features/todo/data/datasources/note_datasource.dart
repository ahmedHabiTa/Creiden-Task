import 'package:creiden/features/todo/domain/entities/note_model.dart';
import 'package:creiden/features/todo/domain/usecases/add_note.dart';
import 'package:creiden/features/todo/domain/usecases/delete_note.dart';

abstract class NoteDatasource {
  Future<List<NoteModel>> getAllNotes();

  Future<NoteModel> addNote({required AddNoteParams params});

  Future<void> updateNote({required AddNoteParams params});

  Future<void> deleteNote({required DeleteNoteParams params});
}
