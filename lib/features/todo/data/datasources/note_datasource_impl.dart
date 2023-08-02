import 'dart:developer';

import 'package:creiden/core/error/exceptions.dart';
import 'package:creiden/features/todo/domain/entities/note_model.dart';
import 'package:creiden/features/todo/domain/usecases/add_note.dart';
import 'package:creiden/features/todo/domain/usecases/delete_note.dart';
import 'package:creiden/local_database.dart';

import 'note_datasource.dart';

class NoteDatasourceImpl implements NoteDatasource {
  final NoteDatabase noteDatabase;
  NoteDatasourceImpl({required this.noteDatabase});
  @override
  Future<List<NoteModel>> getAllNotes() async {
    try {
      final response = await noteDatabase.readAll();
      return response;
    } catch (e) {
      log(e.toString());
      String message = "Ops , Something went wrong...";
      throw NoteException(message: message);
    }
  }

  @override
  Future<NoteModel> addNote({required AddNoteParams params}) async {
    try {
      final response = await noteDatabase.create(NoteModel(
          id: params.id,
          name: params.name,
          color: params.color,
          description: params.description,
          time: params.time,
          date: params.date));
      return response;
    } catch (e) {
      log(e.toString());
      String message = "Ops , Something went wrong...";
      throw NoteException(message: message);
    }
  }

  @override
  Future<void> updateNote({required AddNoteParams params}) async {
    try {
      await noteDatabase.update(NoteModel(
          id: params.id,
          name: params.name,
          color: params.color,
          description: params.description,
          time: params.time,
          date: params.date));
      //return response;
    } catch (e) {
      log(e.toString());
      String message = "Ops , Something went wrong...";
      throw NoteException(message: message);
    }
  }

  @override
  Future<void> deleteNote({required DeleteNoteParams params}) async {
    try {
      final response = await noteDatabase.delete(params.id);
      return response;
    } catch (e) {
      log(e.toString());
      String message = "Ops , Something went wrong...";
      throw NoteException(message: message);
    }
  }
}
