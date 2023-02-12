import 'package:beru_app/Auth/auth_repository.dart';
import 'package:beru_app/ServiceOrder/service_order_repository.dart';
import 'package:beru_app/ServiceOrder/ui/screens/detail_service_order_screen.dart';
import 'package:beru_app/ServiceOrder/ui/widgets/background_assigned_request.dart';
import 'package:beru_app/ServiceOrder/ui/widgets/card_item.dart';
import 'package:beru_app/Widgets/button.dart';
import 'package:beru_app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../Widgets/loading.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_http.dart';
import '../../service_order_model.dart';
import '../service_order_result.dart';

class ListAssignedRequestsScreen extends StatefulWidget {
  const ListAssignedRequestsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListAssignedRequestsScreen();
}

class _ListAssignedRequestsScreen extends State<ListAssignedRequestsScreen> {
  List<ServiceOrderModel> listOrders = [];
  String? next;
  String? prev;
  int count = 0;
  String? urlAPI;

  AuthRepository authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.consentGranted(true);
    OneSignal.shared.setRequiresUserPrivacyConsent(false);

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    await OneSignal.shared.setAppId(await AppHttp.getTokenOneSignal());

    _handlePromptForPushPermission();
  }

  void _handlePromptForPushPermission() {
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) async {
      print("Accepted permission: $accepted");

      var deviceState = await OneSignal.shared.getDeviceState();

      if (deviceState == null || deviceState.userId == null) return;

      authRepository.setTokenDevice(deviceState.userId!);
    });
  }

  Future<List<ServiceOrderModel>> _fetchOrders() async {
    ServiceOrderRepository repository = ServiceOrderRepository();
    ServiceOrderResult cls = await repository.getServiceOrder(urlAPI);

    next = cls.next;
    prev = cls.previous;
    count = cls.count;

    return cls.orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: AppColors.black, toolbarHeight: 0),
        body: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Column(
                children: [
                  Container(
                    color: AppColors.black,
                    child: const BackgroundAssignedRequest(
                        title: "LIST OF ASSIGNED REQUESTS"),
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        // child:_listItems(),
                        child: FutureBuilder(
                            future: _fetchOrders(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return Loading();
                              }

                              if (snapshot.data != null) {
                                List<ServiceOrderModel> listOrders =
                                    snapshot.data as List<ServiceOrderModel>;

                                if (listOrders.isNotEmpty) {
                                  return Column(
                                    children: [
                                      _getOrders(listOrders),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 20, bottom: 20),
                                            child: Text(
                                                'Total orders: ${count.toString()}',
                                                style: const TextStyle(
                                                    fontFamily:
                                                        AppFonts.fontRegular,
                                                    fontSize: 16)),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton.icon(
                                                onPressed: prev == null
                                                    ? null
                                                    : () => setState(
                                                        () => urlAPI = prev),
                                                icon: const Icon(
                                                    Icons.arrow_back),
                                                label: const Text('Prev'),
                                                style: prev != null
                                                    ? ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.green)
                                                    : ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.grey),
                                              ),
                                              const SizedBox(width: 20),
                                              ElevatedButton.icon(
                                                onPressed: next == null
                                                    ? null
                                                    : () => setState(
                                                        () => urlAPI = next),
                                                icon: const Icon(
                                                    Icons.arrow_forward),
                                                label: const Text('Next'),
                                                style: next != null
                                                    ? ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.green)
                                                    : ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              }

                              return _notData();
                            }),
                      ))
                ],
              )
            ]));
  }

  Widget _getOrders(List<ServiceOrderModel> listOrders) {
    return Column(
        children: listOrders.map((order) {
      return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailServiceOrderScreen(
                      serviceOrder: order,
                    ))),
        child: CardItem(serviceOrder: order),
      );
    }).toList());
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
