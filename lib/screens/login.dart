import 'dart:math';

import 'package:atm/database/database_helper.dart';
import 'package:atm/model/saved_preference_model.dart';
import 'package:atm/model/user.dart';
import 'package:atm/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dashboard.dart';

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
  final dbHelper = DatabaseHelper.instance;
  static bool _wrongCredentials;
  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _usernameError = false;
    _passwordError = false;
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();
    _wrongCredentials = false;
  }

  @override
  Widget build(BuildContext context) {

    final usernameWidget = Material(
      child:Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0,vertical: 2.0),
        child: TextField(
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp('[a-zA-Z0-9_.]'))
          ],
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Username"
          ),
          controller: _usernameController,
          onTap: (){
            setState(() {
              _wrongCredentials = false;
            });
          },
        ),
      )
      ,
    );
    final passwordWidget = Material(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0,vertical: 2.0),
        child: TextField(
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp('[0-9]'))
          ],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
            hintText: "Password",
          ),
          controller: _passwordController,
          onTap: (){
            setState(() {
              _wrongCredentials = false;
            });
          },
        ),
      )
      ,
    );

    final loginButton = Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0,vertical: 10.0),
      child: MaterialButton(
        color: Colors.blue,
        padding: EdgeInsets.all(4.0),
        child: Text("Login",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        onPressed: ()async{
          if(_usernameController.text != null && _passwordController.text !=
              null){
            setState(() {
              _isLoading = true;
            });

            if(await login()){
              setState(() {
                _wrongCredentials = false;
                _isLoading = false;
              });
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute
              (builder: (_){
                return Dashboard();
              }),
                  (_)=>false);
            }else{
              setState(() {
                _wrongCredentials = true;
                _isLoading = false;
              });
            }
          }
        },
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
          SizedBox(height: 50.0,),
          Align(
            alignment: Alignment.center,
            child: Text("Please Login",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey
              ),
            ),
          ),
          SizedBox(height: 50.0,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text("Username*",
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 12.0
            ),),
          ),
          usernameWidget,
          SizedBox(height: 20.0,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text("Password*",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 12.0
              ),),
          ),
          passwordWidget,
          _wrongCredentials?Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: Text("Wrong credentials",
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ):Container(),
          _isLoading?Center(
            child: CircularProgressIndicator(),
          ):loginButton,

          Center(child: Text("OR")),

          registerButton,

        ],
      ),
    );
  }
  Future<bool> login() async {
    User userData = await dbHelper.getLogin(_usernameController.text,
        _passwordController.text);
    if(userData != null){
      SavedPreferenceModel.instance.setUserId(userData.id);
      SavedPreferenceModel.instance.setFullName(userData.fullname);
      SavedPreferenceModel.instance.setUserName(userData.username);
      SavedPreferenceModel.instance.setUserAccount(userData.account);
      return true;
    }else{
      return false;
    }
  }
}
