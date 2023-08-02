import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/domain/entities/login_response.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../error/exceptions.dart';

const userCacheConst = "user_cache";
const cacheTokenConst = "cache_token";
const loginInfoConst = "login_info";
const registerBodyConst = "register_body_const";
const cartUUIDConst = "cart_uuid";

abstract class AuthLocalDataSource {
  Future<void> cacheUserData({required LoginResponse user});
  Future<void> cacheCartUUID({required String cartUUID});
  Future<LoginResponse> getCachedUserData();

  Future<void> clearCachedUser();

  Future<void> cacheUserAccessToken({required String token});
  String? getCacheUserAccessToken();
  Future<String> getCachedCartUUID();
  Future<void> cacheUserLoginInfo({required LoginParams params});
  Future<LoginParams> getCacheUserLoginInfo();

  Future<void> clearData();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences sharedPreference;
  AuthLocalDataSourceImpl({required this.sharedPreference});
  @override
  Future<void> cacheUserData({required LoginResponse user}) async {
    try {
      await sharedPreference.setString(
          userCacheConst, jsonEncode(user.toJson()));
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<LoginResponse> getCachedUserData() async {
    try {
      final userShared = sharedPreference.getString(userCacheConst);
      if (userShared != null) {
        return loginResponseFromJson(userShared);
      } else {
        throw CacheException();
      }
    } on CacheException {
      throw CacheException();
    }
  }

  @override
  Future<void> clearCachedUser() async {
    try {
      await sharedPreference.clear();
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserAccessToken({required String token}) async {
    try {
      await sharedPreference.setString(cacheTokenConst, token);
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  String? getCacheUserAccessToken() {
    try {
      final token = sharedPreference.getString(cacheTokenConst);
      if (token != null) {
        return token;
      } else {
        return null;
        // throw CacheException();
      }
    } on CacheException {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserLoginInfo({required LoginParams params}) async {
    try {
      await sharedPreference.setString(
          loginInfoConst, json.encode(params.toMap()));
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<LoginParams> getCacheUserLoginInfo() async {
    try {
      final loginInfo = sharedPreference.getString(loginInfoConst);
      if (loginInfo != null) {
        return LoginParams.fromMap(json.decode(loginInfo));
      } else {
        throw CacheException();
      }
    } catch (e) {
      log(e.toString());
      throw NoCachedUserException();
    }
  }

  @override
  Future<void> clearData() async {
    try {
      await sharedPreference.clear();
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCartUUID({required String cartUUID}) async {
    try {
      await sharedPreference.setString(cartUUIDConst, cartUUID);
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<String> getCachedCartUUID() async {
    try {
      final cartUUID = sharedPreference.getString(cartUUIDConst);
      if (cartUUID != null) {
        return cartUUID;
      } else {
        return '';
      }
    } catch (e) {
      log(e.toString());
      throw NoCachedUserException();
    }
  }
}
