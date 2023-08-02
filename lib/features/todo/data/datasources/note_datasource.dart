import 'package:creiden/features/todo/domain/entities/note_model.dart';
import 'package:creiden/features/todo/domain/usecases/add_note.dart';

abstract class NoteDatasource {
  Future<List<NoteModel>> getAllNotes();

  Future<NoteModel> addNote({required AddNoteParams params});
}
