import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/login_response.dart';
import '../repositories/auth_repository.dart';

class Login extends UseCase<LoginResponse, LoginParams> {
  final AuthRepository repository;
  Login({required this.repository});
  @override
  Future<Either<Failure, LoginResponse>> call(LoginParams params) async {
    return await repository.login(params: params);
  }
}

class LoginParams {
  String email;
  String password;
  LoginParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginParams.fromMap(Map<String, dynamic> map) {
    return LoginParams(
      email: map['email'],
      password: map['password'],
    );
  }
}
