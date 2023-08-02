import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/note_repository.dart';
import 'add_note.dart';

class UpdateNoteUsecase extends UseCase<Unit, AddNoteParams> {
  final NoteRepository repository;
  UpdateNoteUsecase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(AddNoteParams params) async {
    return await repository.updateNote(params: params);
  }
}
