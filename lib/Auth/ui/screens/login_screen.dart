import 'package:beru_app/Auth/ui/widgets/background_auth.dart';
import 'package:beru_app/utils/app_session.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../widgets/form_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  AppSession session = AppSession();

  Future checkSession() async {
    AppSession appSession = AppSession();
    return await appSession.isActiveSession();
  }

  @override
  void initState() {
    super.initState();

    checkSession().then( (isLoggedIn) {
      if (isLoggedIn) {
        Navigator.pushNamed(context, '/list');
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.black, toolbarHeight: 0),
      body: _bodyScreen()
    );
  }

  Widget _bodyScreen(){
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          color: AppColors.black,
          child: const BackgroundAuth(
            title: "LOGIN",
          ),
        ),
        const FormLogin()
      ],
    );
  }
}
