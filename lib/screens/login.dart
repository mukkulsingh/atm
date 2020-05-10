import 'package:atm/screens/register.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  static bool _isLoading;
  static bool _usernameError;
  static bool _passwordError;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _usernameError = false;
    _passwordError = false;
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    final usernameWidget = Material(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0,vertical: 10.0),
        child: TextField(
          controller: _usernameController,
        ),
      ),
    );

    final passwordWidget = Material(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0,vertical: 10.0),
        child: TextField(
          controller: _passwordController,
        ),
      ),
    );

    final loginButton = Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0,vertical: 10.0),
      child: MaterialButton(
        child: Text("Login"),
      ),
    );

    final registerButton = Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0,vertical: 10.0),
      child: MaterialButton(
        child: Text("Register"),
        onPressed: (){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (_){
                return Register();
              }
          ), (_)=>false);
        },
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: <Widget>[
          Text("Please Login"),
          usernameWidget,
          passwordWidget,
          _isLoading?Center(
            child: CircularProgressIndicator(),
          ):loginButton,

          Text("OR"),

          registerButton,

        ],
      ),
    );
  }
}
