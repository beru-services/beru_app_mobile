import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app_session.dart';

abstract class AppHttp {
  Dio http = Dio();
  late String api;

  getHeader() async {
    var token =
        "Token ${(AppSession.user.userId != null) ? AppSession.user.token : ''}";

    return {HttpHeaders.authorizationHeader: token};
  }

  static Future<String> getUrlApi({String apiVersion = 'v1'}) async {
    await dotenv.load(fileName: ".env");
    return '${dotenv.env['API_SERVER']}$apiVersion/';
  }

  static getTokenOneSignal() async {
    await dotenv.load(fileName: ".env");
    if (Platform.isAndroid) {
      return dotenv.env['ONE_SIGNAL_ANDROID'].toString();
    }

    return dotenv.env['ONE_SIGNAL_IOS'].toString();
  }
}
