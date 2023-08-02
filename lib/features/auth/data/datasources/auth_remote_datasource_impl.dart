import 'dart:developer';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/entities/login_response.dart';
import '../../domain/usecases/login.dart';
import 'auth_remote_datasource.dart';

const loginAPI = '/auth/login';
const refreshTokenAPI = '/auth/refresh-token';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiBaseHelper helper;

  AuthRemoteDataSourceImpl({
    required this.helper,
  });
  @override
  Future<LoginResponse> login({required LoginParams params}) async {
    try {
      final response = await helper.post(
        url: loginAPI,
        body: {
          "email": params.email.trim(),
          "password": params.password.trim(),
        },
      ) as Map<String, dynamic>;
      final user = LoginResponse.fromJson(response);
      return user;
    } catch (e) {
      log(e.toString());
      String message = "Please try again";
      if (e is ServerException) {
        message = e.message;
      }
      throw ServerException(message: message);
    }
  }

  @override
  Future<LoginResponse> refreshToken({required String token}) async {
    try {
      final response = await helper.post(
        token: token,
        url: refreshTokenAPI,
        body: {},
      ) as Map<String, dynamic>;
      final user = LoginResponse.fromJson(response);
      return user;
    } catch (e) {
      log(e.toString());
      String message = "Please try again";
      if (e is ServerException) {
        message = e.message;
      }
      throw ServerException(message: message);
    }
  }
}
