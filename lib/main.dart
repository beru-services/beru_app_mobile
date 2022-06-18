import 'package:beru_app/Auth/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'ServiceOrder/ui/screens/list_service_order_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/list': (context) => const ListAssignedRequestsScreen()
      }
    );
  }
}


