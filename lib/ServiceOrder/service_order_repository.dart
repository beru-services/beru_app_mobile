import 'dart:convert';

import 'package:beru_app/ServiceOrder/service_order_model.dart';
import 'package:beru_app/utils/app_http.dart';
import 'package:dio/dio.dart';

class ServiceOrderRepository extends AppHttp {
  Future<List<ServiceOrderModel>> getServiceOrder() async {
    Response response;
    try {
      var header = await getHeader();
      var url = "${await AppHttp.getUrlApi()}process/driver/service-order/";

      response = await http.get(
          url,
          options: Options(headers: header));

      final parsed = response.data['results'].cast<Map<String, dynamic>>();

      return parsed
          .map<ServiceOrderModel>((json) => ServiceOrderModel.fromJson(json))
          .toList();
    } on DioError catch (e) {
      Map error = jsonDecode(jsonEncode(e.response?.data));
      error.forEach((key, value) {
        throw (value);
      });
      return [];
    }
  }

  Future<void> setUpdateStatus(int? orderId, String status) async {
    try {
      var header = await getHeader();
      FormData formData = FormData.fromMap({'id': orderId, 'status': status});

      await http.post(
          "${await AppHttp.getUrlApi()}process/update/service-order/",
          data: formData,
          options: Options(headers: header));

    } on DioError catch (e) {
      Map error = jsonDecode(jsonEncode(e.response?.data));
      error.forEach((key, value) {
        throw (value);
      });
    }
  }
}
