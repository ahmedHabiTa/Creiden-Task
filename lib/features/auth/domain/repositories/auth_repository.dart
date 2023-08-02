import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/login_response.dart';
import '../usecases/login.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login({required LoginParams params});

  Future<Either<Failure, User>> autoLogin();
}
