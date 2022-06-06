import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app_session.dart';

abstract class AppHttp {
  Dio http = Dio();
  late String api;
  Map<String, dynamic> header = {
    HttpHeaders.authorizationHeader:
    "Token ${AppSession.user.token}"
  };

  static Future<String> getUurlAapi({String apiVersion = 'v1'}) async {
    await dotenv.load(fileName: ".env");
    return '${dotenv.env['API_SERVER']}$apiVersion/';
  }

}
