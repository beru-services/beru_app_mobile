import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app_session.dart';

abstract class AppHttp {
  Dio http = Dio();
  late String api;

  getHeader() async {
    print("========= aaaahhhhh");
    print(AppSession.user);
    print("========= xxxxxxx");
   return {
     HttpHeaders.authorizationHeader:
     "Token ${(AppSession.user.userId != null) ? AppSession.user.token : ''}"
   };
  }

  // Future<Map<String, dynamic>> header() async {
  //   AppSession session = AppSession();
  //   if (await session.isActiveSession()) {
  //     return {
  //       HttpHeaders.authorizationHeader:
  //       "Token ${(session.user != null) ? AppSession().user.token : ''}"
  //     };
  //   }
  //
  //   return {};
  //
  // }

  static Future<String> getUurlAapi({String apiVersion = 'v1'}) async {
    await dotenv.load(fileName: ".env");
    return '${dotenv.env['API_SERVER']}$apiVersion/';
  }

}
