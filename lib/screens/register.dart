import 'package:atm/database/database_helper.dart';
import 'package:atm/model/saved_preference_model.dart';
import 'package:atm/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  static bool _inputError;
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
    _inputError = false;
    _fullNameController = new TextEditingController();
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();
    _accountController = new TextEditingController();
  }

  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {

    final fullNameWidget = Container(
      margin: EdgeInsets.symmetric(horizontal: 24,vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.0,vertical: 2.0),
            child: Text("Enter Full Name*",style: TextStyle(color: Colors
                .blueGrey,fontSize: 12.0),),
          ),
          TextField(
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp('[a-zA-Z ]'))
            ],
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Full Name",
            ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.0,vertical: 2.0),
            child: Text("Enter Username*",style: TextStyle(color: Colors
                .blueGrey,fontSize: 12.0),),
          ),
          TextField(
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp('[a-zA-Z0-9._]'))
            ],
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Username",
            ),
            controller: _usernameController,
            onTap: (){
              setState(() {
                _usernameError = false;
              });
            },
          ),
          _usernameError?Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.0,vertical: 2.0),
            child: Text("Enter Password*",style: TextStyle(color: Colors
                .blueGrey,fontSize: 12.0),),
          ),
          TextField(
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
                _passwordError = false;
              });
            },
          ),
          _passwordError?Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.0,vertical: 2.0),
            child: Text("Enter Account number*",style: TextStyle(color: Colors
                .blueGrey,fontSize: 12.0),),
          ),
          TextField(
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp('[0-9]'))
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Account Number",
            ),
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
        color: Colors.blue,
        child: Text("Regitser",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        onPressed: ()async{
          if(_fullNameController.text != null && _usernameController.text !=
              null && _accountController.text != null && _passwordController
              .text != null){
            setState(() {
              _inputError = false;

            });
            if(await _insert()){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute
              (builder: (_){
                return Dashboard();
              }),
                  (_)=>false);
            }
          }else{
            setState(() {
              _inputError = true;
            });
          }
        },
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
          SizedBox(height: 50.0,),
          Align(
            alignment: Alignment.center,
            child: Text("Please Register",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey
              ),
            ),
          ),
          fullNameWidget,
          usernameWidget,
          passwordWidget,
          accountWidget,
          _inputError?Container(
            child: Text("Please fill all details",
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ):Container(),
          _isLoading?Center(
             child: CircularProgressIndicator(),
          ):registerButtonWidget,
          Center(
            child: Text("OR"),
          ),
          loginButtonWidget,
        ],
      ),
    );
  }

  Future<bool> _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : _fullNameController.text,
      DatabaseHelper.columnUsername  : _usernameController.text,
      DatabaseHelper.columnPassword  : _passwordController.text,
      DatabaseHelper.columnAccount  : _accountController.text,
      DatabaseHelper.columnBalance : "0"
    };
    final id = await dbHelper.insert(row);
    if(id != null){
      SavedPreferenceModel.instance.setUserId(id);
      SavedPreferenceModel.instance.setFullName(_fullNameController.text);
      SavedPreferenceModel.instance.setUserName(_usernameController.text);
      SavedPreferenceModel.instance.setUserAccount(_accountController.text);
      return true;
    }else{
      return false;
    }
  }
}
