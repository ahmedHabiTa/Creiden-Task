import 'package:creiden/features/auth/auth_injection.dart';
import 'package:creiden/local_database.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/util/api_basehelper.dart';
import 'features/todo/note_injection.dart';

final sl = GetIt.instance;
final ApiBaseHelper helper = ApiBaseHelper();
Future<void> init() async {
  initNoteInjection(sl);
  initAuthInjection(sl);
  final initDB = NoteDatabase.instance;
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => initDB);

  helper.dioInit();
  sl.registerLazySingleton(() => helper);
}
