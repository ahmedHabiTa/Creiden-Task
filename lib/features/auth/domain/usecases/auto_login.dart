import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/login_response.dart';
import '../repositories/auth_repository.dart';

class AutoLogin extends UseCase<User, NoParams> {
  final AuthRepository repository;
  AutoLogin({required this.repository});

  get f => null;
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.autoLogin();
  }
}
