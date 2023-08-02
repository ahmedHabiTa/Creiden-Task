import 'dart:developer';

import 'package:creiden/core/error/failures.dart';
import 'package:creiden/features/todo/domain/entities/note_model.dart';
import 'package:creiden/features/todo/domain/repositories/note_repository.dart';
import 'package:creiden/features/todo/domain/usecases/add_note.dart';
import 'package:creiden/features/todo/domain/usecases/delete_note.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../datasources/note_datasource.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDatasource datasource;
  NoteRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failure, List<NoteModel>>> getAllNotes() async {
    try {
      final response = await datasource.getAllNotes();
      return Right(response);
    } on NoteException catch (e) {
      log(e.toString());
      return Left(NoteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, NoteModel>> addNote(
      {required AddNoteParams params}) async {
    try {
      final response = await datasource.addNote(params: params);
      return Right(response);
    } on NoteException catch (e) {
      log(e.toString());
      return Left(NoteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNote(
      {required AddNoteParams params}) async {
    try {
      await datasource.updateNote(params: params);
      return const Right(unit);
    } on NoteException catch (e) {
      log(e.toString());
      return Left(NoteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote(
      {required DeleteNoteParams params}) async {
    try {
      await datasource.deleteNote(params: params);
      return const Right(unit);
    } on NoteException catch (e) {
      log(e.toString());
      return Left(NoteFailure(message: e.message));
    }
  }
}
