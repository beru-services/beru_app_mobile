import 'package:beru_app/ServiceOrder/service_order_model.dart';
import 'package:beru_app/utils/app_http.dart';
import 'package:dio/dio.dart';

class ServiceOrderRepository extends AppHttp {
  Future<ServiceOrderModel> getServiceOrder() async {
    Response response;
    try {
      var header = await getHeader();

      response = await http.get(
          "${await AppHttp.getUurlAapi()}process/driver/service-order/",
          options: Options(headers: header)
      );

      final parsed = response.data['results'].cast<Map<String, dynamic>>();

      return parsed.map<ServiceOrderModel>((json) => ServiceOrderModel.fromJson(json)).toList();

    } on DioError catch (e) {
      print('errr');
      Map error = e.response!.data;
      error.forEach((key, value) => throw (value));
      print(e);
      return [] as ServiceOrderModel;
    }
  }
}