import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

import '../error/exceptions.dart';

class ApiBaseHelper {
  final String _baseUrl =
      "https://phpstack-561490-3524079.cloudwaysapps.com/api-start-point/public/api";
  final Dio dio = Dio();
  void dioInit() {
    dio.options.baseUrl = _baseUrl;
    dio.options.headers = headers;
    dio.options.sendTimeout = 30000; // time in ms
    dio.options.connectTimeout = 30000; // time in ms
    dio.options.receiveTimeout = 30000;
  }

  void updateLocalInHeaders(String local) {
    headers["lang"] = local;
    dio.options.headers = headers;
  }

  ApiBaseHelper();
  Map<String, String> headers = {
    "accept": "application/json",
    "Content-Type": 'application/json',
  };

  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
        dio.options.headers = headers;
        log(url + token);
      }
      log(body.toString());
      FormData formData = FormData.fromMap(body);

      log(url);
      final Response response = await dio.post(url, data: formData);
      final responseJson = _returnResponse(response);
      log(responseJson.toString());
      return responseJson;
    } on SocketException {
      throw ServerException(message: tr("No Internet Connection"));
    } on DioError catch (e) {
      log(e.toString());
      log(e.response?.toString() ?? "no response");
      String message = 'Invalid Email or Password...';
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectTimeout ||
          e.message.contains('SocketException')) {
        message = tr("error_no_internet");
      }
      throw ServerException(message: message);
    }
  }

  //

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 422:
        throw response.data.toString();
      case 401:
      case 403:
        throw UnauthorizedException(message: response.data);
      case 500:
      default:
        debugPrint(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode} ${response.data}');
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode} ${response.data}');
    }
  }
}

class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);
  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([message]) : super(message, "Unauthorized: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
