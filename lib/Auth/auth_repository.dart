import 'dart:convert';
import 'dart:io';

import 'package:beru_app/utils/app_http.dart';
import 'package:dio/dio.dart';

import '../utils/app_session.dart';

class AuthRepository extends AppHttp {
  Future<bool> makeLogin(Map<String, dynamic> dataLogin) async {

    Response resp;
    try {
      FormData formData = FormData.fromMap(dataLogin);
      var url = "${await AppHttp.getUrlApi()}backend/auth/";

      resp = await http.post(
          url,
          data: formData,
      );

      ModelSession modelSession = ModelSession.fromJson(resp.data);

      if (modelSession.userId is int) {
        await AppSession().register(modelSession);

        return true;
      }

    } on DioError catch (e) {
      print(e.response?.data);
      Map error = jsonDecode(jsonEncode(e.response?.data));

      error.forEach((key, value) {
        throw (value);
      });
    }

    return false;

  }

  Future<bool> recoveryPassword(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      var url = "${await AppHttp.getUrlApi()}backend/reset-password/";
      await http.post(url, data: formData);
      return true;
    } on DioError catch (e) {
      Map error = jsonDecode(jsonEncode(e.response?.data));

      error.forEach((key, value) {
        throw (value);
      });
    }

    return false;
  }

  Future<bool> changePassword(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      var url = "${await AppHttp.getUrlApi()}backend/change-password/";
      print(url);
      await http.post(url, data: formData);
      return true;
    } on DioError catch (e) {
      Map error = jsonDecode(jsonEncode(e.response?.data));

      error.forEach((key, value) {
        throw (value);
      });
    }

    return false;
  }

  Future setTokenDevice(String token) async {
    try {
      FormData formData = FormData.fromMap({
        'token_device': token,
        'type_device': Platform.isAndroid ? 'Android' : 'iOS'
      });

      var header = await getHeader();

      var url = "${await AppHttp.getUrlApi()}backend/token-device/";

      await http.post(url, data: formData, options: Options(headers: header));

    } on DioError catch (e) {
      Map error = jsonDecode(jsonEncode(e.response?.data));

      error.forEach((key, value) {
        throw (value);
      });
    }
  }
}