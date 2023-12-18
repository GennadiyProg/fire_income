import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fire_income/dev_variables.dart';

class DioRequest{
  static String? token;
  static String address = devApiAddress ?? "http://192.168.43.47:8080";

  static getRequest(String url, Map<String, dynamic> params) {
    return Dio().get(
      '$address/$url',
      queryParameters: params,
      options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Basic $token'
          }
      ),
    );
  }

  static postRequest(String url, [Map<String, dynamic>? data]) {
    return Dio().post(
      '$address/$url',
      data: data,
      options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Basic $token'
          },
          contentType: Headers.jsonContentType
      ),
    );
  }

  static deleteRequest(String url) {
    return Dio().delete(
      '$address/$url',
      options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Basic $token'
          },
      ),
    );
  }
}