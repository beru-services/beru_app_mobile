import 'package:beru_app/AssignedRequests/ui/widgets/background_assigned_request.dart';
import 'package:beru_app/AssignedRequests/ui/widgets/card_item.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../service_order_model.dart';

class ListAssignedRequestsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListAssignedRequestsScreen();
}

class _ListAssignedRequestsScreen extends State<ListAssignedRequestsScreen> {
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
                child:_listItems(),
              )
            )
          ],
        ));
  }

  Widget _listItems() {
    return Column(children: const [
      CardItem(client: 'Titulo', status: StatusServiceOrder.D,),
      CardItem(client: 'Cliente uno', status: StatusServiceOrder.S,),
      CardItem(client: 'Titulo', status: StatusServiceOrder.T,),
      CardItem(client: 'ANGEL BEJARANO', status: StatusServiceOrder.A,),
    ]);
  }
}
