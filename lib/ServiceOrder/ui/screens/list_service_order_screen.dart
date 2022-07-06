import 'package:beru_app/ServiceOrder/service_order_repository.dart';
import 'package:beru_app/ServiceOrder/ui/screens/detail_service_order_screen.dart';
import 'package:beru_app/ServiceOrder/ui/widgets/background_assigned_request.dart';
import 'package:beru_app/ServiceOrder/ui/widgets/card_item.dart';
import 'package:beru_app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/loading.dart';
import '../../../utils/app_colors.dart';
import '../../service_order_model.dart';

class ListAssignedRequestsScreen extends StatefulWidget {
  const ListAssignedRequestsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListAssignedRequestsScreen();
}

class _ListAssignedRequestsScreen extends State<ListAssignedRequestsScreen> {
  ServiceOrderRepository repository = ServiceOrderRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: AppColors.black, toolbarHeight: 0),
        body: Column(
          children: [
            Container(
              color: AppColors.black,
              child: const BackgroundAssignedRequest(
                  title: "LIST OF ASSIGNED REQUESTS"),
            ),
            Container(
                height: 480,
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  // child:_listItems(),
                  child: FutureBuilder(
                      future: repository.getServiceOrder(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Loading();
                        }

                        if (snapshot.data != null) {
                          List<ServiceOrderModel> listOrders =
                              snapshot.data as List<ServiceOrderModel>;

                          if (listOrders.isNotEmpty) {
                            return Column(
                              children: listOrders.map((order) {
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailServiceOrderScreen(
                                                serviceOrder: order,
                                              ))),
                                  child: CardItem(serviceOrder: order),
                                );
                              }).toList(),
                            );
                          }
                        }

                        return _notData();
                      }),
                ))
          ],
        ));
  }

  Widget _notData() {
    return const Padding(
      padding: EdgeInsets.only(top: 60),
      child: Text(
        'Has no orders assigned',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontFamily: AppFonts.fontMedium),
      ),
    );
  }
}
