import 'package:beru_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/app_fonts.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: CircularProgressIndicator(color: AppColors.green,),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "REQUEST IN PROGRESS",
              style: TextStyle(
                fontFamily: AppFonts.fontRegular,
              ),
            ),
          )
        ],
      ),
    );
  }
}