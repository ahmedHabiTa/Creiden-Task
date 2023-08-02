import 'package:creiden/features/todo/data/datasources/note_datasource.dart';
import 'package:creiden/features/todo/data/repositories/note_repository_impl.dart';
import 'package:creiden/features/todo/domain/repositories/note_repository.dart';
import 'package:creiden/features/todo/domain/usecases/add_note.dart';
import 'package:creiden/features/todo/domain/usecases/delete_note.dart';
import 'package:creiden/features/todo/domain/usecases/get_all_notes.dart';
import 'package:creiden/features/todo/domain/usecases/update_note.dart';
import 'package:creiden/features/todo/presentation/cubit/add_note/add_note_cubit.dart';
import 'package:creiden/features/todo/presentation/cubit/delete_note/delete_note_cubit.dart';
import 'package:creiden/features/todo/presentation/cubit/get_all_notes/get_all_notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../injection_container.dart';
import 'data/datasources/note_datasource_impl.dart';

Future<void> initNoteInjection(GetIt sl) async {
  sl.registerLazySingleton(() => GetAllNotesCubit(getAllNotesUsecase: sl()));
  sl.registerLazySingleton(() => DeleteNoteCubit(deleteNoteUsecase: sl()));
  sl.registerLazySingleton(
      () => AddNoteCubit(addNoteUsecase: sl(), updateNoteUsecase: sl()));

  sl.registerLazySingleton(() => GetAllNotesUsecase(repository: sl()));
  sl.registerLazySingleton(() => AddNoteUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateNoteUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeleteNoteUsecase(repository: sl()));

  sl.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(datasource: sl()),
  );

  //* Data sources
  sl.registerLazySingleton<NoteDatasource>(
    () => NoteDatasourceImpl(
      noteDatabase: sl(),
    ),
  );
}

List<BlocProvider> noteBlocs(BuildContext context) => [
      BlocProvider<GetAllNotesCubit>(
          create: (BuildContext context) =>
              sl<GetAllNotesCubit>()..fReadAllNotes(context)),
      BlocProvider<AddNoteCubit>(
          create: (BuildContext context) => sl<AddNoteCubit>()),
      BlocProvider<DeleteNoteCubit>(
          create: (BuildContext context) => sl<DeleteNoteCubit>()),
    ];
