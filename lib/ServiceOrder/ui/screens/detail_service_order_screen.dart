import 'dart:ffi';

import 'package:beru_app/ServiceOrder/service_order_model.dart';
import 'package:beru_app/ServiceOrder/service_order_repository.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';

import '../../../Widgets/button.dart';
import '../../../Widgets/loading.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../widgets/background_assigned_request.dart';

class DetailServiceOrderScreen extends StatefulWidget {
  final ServiceOrderModel serviceOrder;

  const DetailServiceOrderScreen({Key? key, required this.serviceOrder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailServiceOrderScreen();
}

class _DetailServiceOrderScreen extends State<DetailServiceOrderScreen> {
  ServiceOrderRepository repository = ServiceOrderRepository();
  bool _makeRequest = false;

  @override
  void initState() {
    super.initState();
  }

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
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _contain(
                      'PICKED UP',
                      Icons.location_on_outlined,
                      widget.serviceOrder.status == StatusServiceOrder.A,
                      () => (_makeRequest) ? Loading() : _updateStatus(StatusServiceOrder.S)),
                  _contain(
                      'IN TRANSIT',
                      Icons.delivery_dining_outlined,
                      widget.serviceOrder.status == StatusServiceOrder.S,
                      () => openMapsSheet(context, StatusServiceOrder.T)),
                  _contain(
                      'DELIVERED',
                      Icons.location_searching_rounded,
                      widget.serviceOrder.status == StatusServiceOrder.T,
                      () => (_makeRequest) ? Loading() : _updateStatus(StatusServiceOrder.D)),
                  _back(),
                ],
              ))
        ],
      ),
    );
  }

  Widget _contain(
      String title, IconData icon, bool activeState, VoidCallback action) {
    return GestureDetector(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGrey,
              offset: Offset(
                0.0,
                2.0,
              ),
              blurRadius: 3.0,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(1, 0),
              blurRadius: 2,
              spreadRadius: 1.0,
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Icon(icon,
                    color: activeState == true
                        ? AppColors.green
                        : AppColors.lightGrey)),
            Expanded(
                flex: 8,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: activeState == true
                          ? AppColors.black
                          : AppColors.lightGrey,
                      fontFamily: AppFonts.fontRegular),
                ))
          ],
        ),
      ),
    );
  }

  Widget _back() {
    return Container(
        margin: const EdgeInsets.only(top: 40),
        child: Button(
          padding: const EdgeInsets.symmetric(vertical: 20),
          label: "RETURN",
          onTab: () => Navigator.pushNamed(context, '/list'),
        ));
  }

  openMapsSheet(context, StatusServiceOrder status) async {
    try {
      var client = widget.serviceOrder.client;

      final coords = Coords(
          double.parse(client?.lon ?? '0'), double.parse(client?.lat ?? '0'));
      const title = "Ocean Beach";
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () {
                          map.showMarker(
                            coords: coords,
                            title: title,
                          );
                          _updateStatus(status);
                        },
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void updateState(bool state) {
    setState(() {
      _makeRequest = state;
    });
  }

  void _updateStatus(StatusServiceOrder status) async {
    if (widget.serviceOrder.id != null) {
      updateState(true);
      await repository.setUpdateStatus(widget.serviceOrder.id,
          ServiceOrderModel.statusObjectToString(status));
      Toast.show('The order has been updated', duration: 5, gravity: Toast.bottom);

      updateState(false);

      Navigator.pushNamed(context, '/list');

    }
  }
}
