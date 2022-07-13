import 'package:beru_app/Auth/ui/widgets/form_change_password.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../widgets/background_auth.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email;

  const ChangePasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.black, toolbarHeight: 0),
      body: _bodyScreen(),
    );
  }

  Widget _bodyScreen() {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          color: AppColors.black,
          child: const BackgroundAuth(
            title: "CHANGE PASSWORD",
          ),
        ),
        FormChangePassword(email: widget.email),
      ],
    );
  }

  Widget _headChancePassword() {
    return Container(
      color: AppColors.black,
      child: const BackgroundAuth(
        title: "CHANCE PASSWORD",
      ),
    );
  }
}
