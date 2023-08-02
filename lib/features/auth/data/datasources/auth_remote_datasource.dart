import '../../domain/entities/login_response.dart';
import '../../domain/usecases/login.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login({required LoginParams params});

  Future<LoginResponse> refreshToken({required String? token});
}
