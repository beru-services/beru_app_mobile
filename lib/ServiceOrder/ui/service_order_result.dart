import '../service_order_model.dart';

class ServiceOrderResult {
  List<ServiceOrderModel> orders = [];
  final String? next;
  final String? previous;
  final int count;

  ServiceOrderResult(this.orders, this.next, this.previous, this.count);

}