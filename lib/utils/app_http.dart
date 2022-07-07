import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app_session.dart';

abstract class AppHttp {
  Dio http = Dio();
  late String api;

  getHeader() async {
    var token = "Token ${(AppSession.user.userId != null) ? AppSession.user.token : ''}";
    print(token);
    return {
      HttpHeaders.authorizationHeader:
          "Token ${(AppSession.user.userId != null) ? AppSession.user.token : ''}"
    };
  }

  static Future<String> getUrlApi({String apiVersion = 'v1'}) async {
    await dotenv.load(fileName: ".env");
    return '${dotenv.env['API_SERVER']}$apiVersion/';
  }

  static getTokenOneSignal() async {
    await dotenv.load(fileName: ".env");
    return dotenv.env['ONE_SIGNAL'].toString();
  }
}
