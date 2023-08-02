import 'package:creiden/local_database.dart';
import 'package:get_it/get_it.dart';

import 'features/core/util/api_basehelper.dart';
import 'features/todo/note_injection.dart';

final sl = GetIt.instance;
final ApiBaseHelper helper = ApiBaseHelper();

Future<void> init() async {
  initNoteInjection(sl);
  final initDB = NoteDatabase.instance;
  sl.registerLazySingleton(() => initDB);

  helper.dioInit();
}
