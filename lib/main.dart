import 'package:atm/screens/dashboard.dart';
import 'package:atm/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _isLoggedIn;
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int id = preferences.getInt("userId");
  if(id != null){
    _isLoggedIn = true;
  }else{
    _isLoggedIn = false;
  }
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _isLoggedIn?Dashboard():Login(),
    );
  }
}
