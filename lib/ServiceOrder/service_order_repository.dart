import 'dart:convert';

import 'package:beru_app/ServiceOrder/service_order_model.dart';
import 'package:beru_app/ServiceOrder/ui/service_order_result.dart';
import 'package:beru_app/utils/app_http.dart';
import 'package:dio/dio.dart';

class ServiceOrderRepository extends AppHttp {
  Future<ServiceOrderResult> getServiceOrder(String? urlAPI) async {
    print("AQUI");
    Response response;
    try {
      var header = await getHeader();
      String url = urlAPI ?? "${await AppHttp.getUrlApi()}process/driver/service-order/";

      response = await http.get(
          url,
          options: Options(headers: header));

      final parsed = response.data['results'].cast<Map<String, dynamic>>();

      return ServiceOrderResult(parsed
          .map<ServiceOrderModel>((json) => ServiceOrderModel.fromJson(json))
          .toList(), response.data['next'],
          response.data['previous'],
          response.data['count']
      );

    } on DioError catch (e) {
      Map error = jsonDecode(jsonEncode(e.response?.data));
      error.forEach((key, value) {
        throw (value);
      });

       return ServiceOrderResult([], null, null, 0);
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
