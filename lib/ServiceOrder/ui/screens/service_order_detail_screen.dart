import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../service_order_model.dart';
import '../widgets/background_assigned_request.dart';

class ServiceOrderDetailScreen extends StatefulWidget {
  final ServiceOrderModel serviceOrder;

  const ServiceOrderDetailScreen({Key? key, required this.serviceOrder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ServiceOrderDetailScreen();
}

class _ServiceOrderDetailScreen extends State<ServiceOrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: AppColors.black, toolbarHeight: 0),
        body: Column(children: [
          Container(
            color: AppColors.black,
            child: const BackgroundAssignedRequest(
                title: "LIST OF ASSIGNED REQUESTS"),
          ),
        ]));
  }
}
