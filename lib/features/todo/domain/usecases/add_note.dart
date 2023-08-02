import 'package:creiden/features/todo/domain/entities/note_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/note_repository.dart';

class AddNoteUsecase extends UseCase<NoteModel, AddNoteParams> {
  final NoteRepository repository;
  AddNoteUsecase({required this.repository});
  @override
  Future<Either<Failure, NoteModel>> call(AddNoteParams params) async {
    return await repository.addNote(params: params);
  }
}

class AddNoteParams {
  int id;
  String name;
  String color;
  String description;
  String date;
  String time;
  AddNoteParams({
    required this.id,
    required this.name,
    required this.color,
    required this.description,
    required this.date,
    required this.time,
  });
}
