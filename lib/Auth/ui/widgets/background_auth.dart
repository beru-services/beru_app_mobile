import 'package:beru_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_fonts.dart';

class BackgroundAuth extends StatelessWidget {
  final String title;
  const BackgroundAuth({Key? key, required this.title,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container (
      alignment: Alignment.center,
      height: 320,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 280,
            width: 341,
            decoration: const BoxDecoration(
              color: AppColors.black,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/bg.png"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 160),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: AppFonts.fontRegular,
                color: Colors.white,
              ),
            ),
          )
        ],
      )
    );
  }

}