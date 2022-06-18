import 'dart:convert';

import 'package:beru_app/utils/app_http.dart';
import 'package:dio/dio.dart';

import '../utils/app_session.dart';

class AuthRepository extends AppHttp {
  Future<bool> makeLogin(Map<String, dynamic> dataLogin) async {
    Response resp;
    try {
      FormData formData = FormData.fromMap(dataLogin);
      var url = "${await AppHttp.getUurlAapi()}backend/auth/";
      print(url);
      resp = await http.post(
          url,
          data: formData
      );

      ModelSession modelSession = ModelSession.fromJson(resp.data);

      if (modelSession.userId is int) {
        await AppSession().register(modelSession);

        return true;
      }

    } on DioError catch (e) {

      Map error = jsonDecode(jsonEncode(e.response?.data));
      error.forEach((key, value) {
        print(value);
        print("==========");
        throw (value);
      });
    }

    return false;

  }

  // Future retrievePassword(Map<String, dynamic> data) async {
  //   Response resp;
  //   try {
  //     FormData formData = new FormData.fromMap(data);
  //     resp = await http.post(await AppHttp.getUurlAapi() + 'config/restaurar-clave/', data: formData);
  //   } on DioError catch (e) {
  //     Map error = jsonDecode(jsonEncode(e.response.data));
  //     error.forEach((key, value) {
  //       throw (value);
  //     });
  //   }
  //   return resp.data;
  // }
}