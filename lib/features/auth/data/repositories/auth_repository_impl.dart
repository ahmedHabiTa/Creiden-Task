import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/local/auth_local_datasource.dart';
import '../../domain/entities/login_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;
  AuthRepositoryImpl({
    required this.remote,
    required this.local,
  });
  @override
  Future<Either<Failure, LoginResponse>> login(
      {required LoginParams params}) async {
    try {
      final userData = await remote.login(params: params);
      await local.cacheUserData(user: userData);
      await local.cacheUserAccessToken(token: userData.data.token);
      await local.cacheUserLoginInfo(
          params: LoginParams(
        password: params.password,
        email: params.email,
      ));
      return Right(userData);
    } on ServerException catch (e) {
      log(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> autoLogin() async {
    try {
      final token = local.getCacheUserAccessToken();
      final user = await remote.refreshToken(token: token!);
      await local.cacheUserData(user: user);
      await local.cacheUserAccessToken(token: user.data.token);
      return Right(user.data.user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
      // ignore: nullable_type_in_catch_clause
    } on NoCachedUserException {
      return Left(NoCachedUserFailure());
    }
  }
}
