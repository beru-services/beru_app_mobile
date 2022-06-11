import 'package:beru_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../service_order_model.dart';

class CardItem extends StatelessWidget {
  final String client;
  final StatusServiceOrder status;

  const CardItem({Key? key, required this.client, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey,
            offset: Offset(
              0.0,
              4.0,
            ),
            blurRadius: 3.0,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(2, 0),
            blurRadius: 4,
            spreadRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                height: 125,
                width: 200,
                // color: _colorStatusOrder(StatusServiceOrder.S),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: _colorStatusOrder(status)),
                child: _iconStatusOrder(status),
              )),
          const Expanded(flex: 0, child: Text('')),
          Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 10, top: 10),
                      child: Text(
                        "CUSTOMER NAME",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.lightGrey,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 10),
                    child: Text(
                      client,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 10),
                      child: Text(
                        "CREATION DATE",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.lightGrey,
                        ),
                      )),
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                      left: 10,
                    ),
                    child: Text(
                      '30/02/2022',
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Icon _iconStatusOrder(StatusServiceOrder status) {
    if (status == StatusServiceOrder.A) {
      return const Icon(Icons.info_rounded, color: Colors.white, size: 24.0);
    } else if (status == StatusServiceOrder.S ) {
      return const Icon(
        Icons.flag_circle_rounded,
        color: Colors.white,
        size: 32.0,
      );
    } else if (status == StatusServiceOrder.T) {
      return const Icon(
        Icons.location_on_outlined,
        color: Colors.white,
        size: 32.0,
      );
    }

    return const Icon(
      Icons.check_circle,
      color: Colors.white,
      size: 24.0,
    );
  }

  _colorStatusOrder(StatusServiceOrder status) {
    if (status == StatusServiceOrder.A) {
      return AppColors.yellow;
    } else if (status == StatusServiceOrder.S) {
      return AppColors.blue;
    } else if (status == StatusServiceOrder.T) {
      return AppColors.lightGreen;
    }

    return AppColors.green;
  }
}