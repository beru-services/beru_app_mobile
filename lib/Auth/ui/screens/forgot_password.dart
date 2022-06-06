import 'package:beru_app/Auth/ui/widgets/form_forgot_password.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../widgets/background_auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.black, toolbarHeight: 0),
      body: Column(
        children: [
          _headForgotPassword(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [_message(), const FormForgotPassword(), _back()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headForgotPassword() {
    return Container(
      color: AppColors.black,
      child: const BackgroundAuth(
        title: "LOGIN",
      ),
    );
  }

  Widget _back() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(false),
      child: const Text(
        "Join the Application",
        style:
            TextStyle(fontFamily: AppFonts.fontLight, color: AppColors.black),
      ),
    );
  }

  Widget _message() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      alignment: Alignment.center,
      child: const Text(
        "RECOVER PASSWORD",
        textAlign: TextAlign.start,
        style: TextStyle(fontFamily: AppFonts.fontMedium, fontSize: 20),
        maxLines: 3,
      ),
    );
  }
}
