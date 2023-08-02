import 'package:creiden/features/todo/domain/entities/note_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/note_repository.dart';

class GetAllNotesUsecase extends UseCase<List<NoteModel>, NoParams> {
  final NoteRepository repository;
  GetAllNotesUsecase({required this.repository});
  @override
  Future<Either<Failure, List<NoteModel>>> call(NoParams params) async {
    return await repository.getAllNotes();
  }
}
