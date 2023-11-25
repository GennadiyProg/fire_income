import 'dart:io';

import 'package:dio/dio.dart';

class DioRequest{
  static String? token;

  static getRequest(String url, Map<String, dynamic> params) {
    return Dio().get(
      'http://192.168.0.10:8080/$url',
      queryParameters: params,
      options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Basic $token'
          }
      ),
    );
  }

  static postRequest(String url, Map<String, dynamic> data) {
    return Dio().post(
      'http://192.168.0.10:8080/$url',
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
      'http://192.168.0.10:8080/$url',
      options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Basic $token'
          },
      ),
    );
  }
}