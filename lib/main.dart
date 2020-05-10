import 'package:atm/screens/dashboard.dart';
import 'package:atm/screens/login.dart';
import 'package:flutter/material.dart';

import 'model/login_model.dart';

void main()=>runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static bool _isLoggedIn;

  void checkLogin()async{
    _isLoggedIn = await LoginModel.instance.checkIfLoggedIn();
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _isLoggedIn?Dashboard():Login(),
    );
  }
}
