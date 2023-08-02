import 'package:creiden/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:creiden/features/auth/domain/repositories/auth_repository.dart';
import 'package:creiden/features/auth/domain/usecases/auto_login.dart';
import 'package:creiden/features/auth/domain/usecases/login.dart';
import 'package:creiden/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import 'package:creiden/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../core/local/auth_local_datasource.dart';
import '../../injection_container.dart';
import 'data/datasources/auth_remote_datasource_impl.dart';
import 'data/repositories/auth_repository_impl.dart';

Future<void> initAuthInjection(GetIt sl) async {
  sl.registerLazySingleton(() => LoginCubit(login: sl()));
  sl.registerLazySingleton(() => AutoLoginCubit(autoLogin: sl()));

  sl.registerLazySingleton(() => Login(repository: sl()));
  sl.registerLazySingleton(() => AutoLogin(repository: sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(local: sl(), remote: sl()),
  );

  //* Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      helper: sl(),
    ),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sharedPreference: sl(),
    ),
  );
}

List<BlocProvider> authBlocs(BuildContext context) => [
      BlocProvider<LoginCubit>(
          create: (BuildContext context) => sl<LoginCubit>()),
      BlocProvider<AutoLoginCubit>(
          create: (BuildContext context) => sl<AutoLoginCubit>()..fAutoLogin()),
    ];
