import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

class BackgroundAssignedRequest extends StatelessWidget {
  final String title;

  const BackgroundAssignedRequest({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
            child: Row(
              children: [
                _logo(),
                const Expanded(flex: 1, child: Text('')),
                _logout(),
                _titleLogOut()
              ],
            ),
          ),
          _title()
        ],
      ),
    );
  }

  Widget _titleLogOut() {
    return Expanded(
        flex: 0,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: const Text(
            "LOGOUT",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: AppFonts.fontMedium,
                color: Colors.white,
                fontSize: 16),
          ),
        ));
  }

  Widget _logout() {
    return Expanded(
      flex: 0,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: 97,
        width: 90,
        decoration: const BoxDecoration(
          color: AppColors.black,
          image: DecorationImage(
            image: AssetImage("images/logout.png"),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: 97,
        width: 90,
        decoration: const BoxDecoration(
          color: AppColors.black,
          image: DecorationImage(
            image: AssetImage("images/logo.png"),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: AppFonts.fontMedium,
          fontSize: 27.5,
          color: Colors.white,
        ),
      ),
    );
  }
}
