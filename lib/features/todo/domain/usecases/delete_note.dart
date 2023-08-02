import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/note_repository.dart';

class DeleteNoteUsecase extends UseCase<Unit, DeleteNoteParams> {
  final NoteRepository repository;
  DeleteNoteUsecase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(DeleteNoteParams params) async {
    return await repository.deleteNote(params: params);
  }
}

class DeleteNoteParams {
  final int id;
  DeleteNoteParams({required this.id});
}
