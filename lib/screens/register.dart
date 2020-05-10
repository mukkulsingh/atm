import 'package:flutter/material.dart';

import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  static bool _fullNameError;
  static bool _usernameError;
  static bool _passwordError;
  static bool _accountError;
  static bool _isLoading;

  TextEditingController _fullNameController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  TextEditingController _accountController;

  @override
  void initState() {
    super.initState();
    _fullNameError = false;
    _usernameError = false;
    _passwordError = false;
    _accountError = false;
    _isLoading = false;
    _fullNameController = new TextEditingController();
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();
    _accountController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    final fullNameWidget = Container(
      margin: EdgeInsets.symmetric(horizontal: 24,vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.0,vertical: 2.0),
            child: Text("Enter Full Name*",style: TextStyle(color: Colors
                .blueGrey,fontSize: 12.0),),
          ),
          TextField(
            controller: _fullNameController,
            onTap: (){
              setState(() {
                _fullNameError = false;
              });
            },
          ),
          _fullNameError?Container(
            child: Text("Please enter a valid name",style: TextStyle(
              color: Colors.red,
              fontSize: 12.0
            ),),
          ):Container(),
        ],
      ),
    );


    final usernameWidget = Container(
      margin: EdgeInsets.symmetric(horizontal: 24,vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.0,vertical: 2.0),
            child: Text("Enter Username*",style: TextStyle(color: Colors
                .blueGrey,fontSize: 12.0),),
          ),
          TextField(
            controller: _usernameController,
            onTap: (){
              setState(() {
                _usernameError = false;
              });
            },
          ),
          _fullNameError?Container(
            child: Text("Please enter a valid username",style: TextStyle(
                color: Colors.red,
                fontSize: 12.0
            ),),
          ):Container(),
        ],
      ),
    );

    final passwordWidget = Container(
      margin: EdgeInsets.symmetric(horizontal: 24,vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.0,vertical: 2.0),
            child: Text("Enter Password*",style: TextStyle(color: Colors
                .blueGrey,fontSize: 12.0),),
          ),
          TextField(
            controller: _passwordController,
            onTap: (){
              setState(() {
                _passwordError = false;
              });
            },
          ),
          _fullNameError?Container(
            child: Text("Please enter a valid password",style: TextStyle(
                color: Colors.red,
                fontSize: 12.0
            ),),
          ):Container(),
        ],
      ),
    );

    final accountWidget = Container(
      margin: EdgeInsets.symmetric(horizontal: 24,vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.0,vertical: 2.0),
            child: Text("Enter Account number*",style: TextStyle(color: Colors
                .blueGrey,fontSize: 12.0),),
          ),
          TextField(
            controller: _accountController,
            onTap: (){
              setState(() {
                _accountError = false;
              });
            },
          ),
          _fullNameError?Container(
            child: Text("Please enter a valid account number",style: TextStyle(
                color: Colors.red,
                fontSize: 12.0
            ),),
          ):Container(),
        ],
      ),
    );

    final registerButtonWidget = Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: MaterialButton(
        child: Text("Regitser"),
      ),
    );

    final loginButtonWidget = Container(
      child: MaterialButton(
        child: Text("Login",),
        onPressed: (){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (_){
              return Login();
            }
          ), (_)=>false);
        },
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: <Widget>[
          Text("Register"),
          fullNameWidget,
          usernameWidget,
          passwordWidget,
          accountWidget,
          _isLoading?Center(
             child: CircularProgressIndicator(),
          ):registerButtonWidget,
          Text("OR"),
          loginButtonWidget,
        ],
      ),
    );
  }
}
