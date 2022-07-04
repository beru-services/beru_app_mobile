import 'dart:convert';

import 'package:beru_app/ServiceOrder/service_order_model.dart';
import 'package:beru_app/utils/app_http.dart';
import 'package:dio/dio.dart';

class ServiceOrderRepository extends AppHttp {
  Future<List<ServiceOrderModel>> getServiceOrder() async {
    Response response;
    try {
      var header = await getHeader();

      response = await http.get(
          "${await AppHttp.getUrlApi()}process/driver/service-order/",
          options: Options(headers: header));

      final parsed = response.data['results'].cast<Map<String, dynamic>>();
      var data = parsed
          .map<ServiceOrderModel>((json) => ServiceOrderModel.fromJson(json))
          .toList();

      return data;
    } on DioError catch (e) {
      print("errroorrr");
      Map error = jsonDecode(jsonEncode(e.response?.data));
      error.forEach((key, value) {
        print(value);
        throw (value);
      });
    }

    return [];
  }
}
