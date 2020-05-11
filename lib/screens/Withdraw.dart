import 'package:atm/database/database_helper.dart';
import 'package:atm/model/saved_preference_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Withdraw extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final dbHelper = DatabaseHelper.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _depositController;
  static bool _isLoading;
  static bool _isPageLoading;
  static double balance=0;
  static String _username;
  void getBalance()async{
    _username = await SavedPreferenceModel.instance.getUserName();
    balance = await dbHelper.getBalance(_username);
    if(balance == null){
      balance = 0.0;
    }
    setState(() {
      _isPageLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _depositController = new TextEditingController();
    _isPageLoading = true;
    getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Withdraw"),
      ),
      body: _isPageLoading?
      Center(
        child: CircularProgressIndicator(),
      ):
      ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(10.0),
            height: 100.0,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                  color: Colors.blueGrey,
                )
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Current Balance:",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 22.0
                  ),
                ),
                Text("${balance??0}",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24.0
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 1),
            child: Text("Withodraw Amount*",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 12.0,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp('[0-9.]'))
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Ex: 100"
              ),
              controller: _depositController,
            ),
          ),
          _isLoading?Center(
            child: CircularProgressIndicator(),):
          RaisedButton(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text("Withdraw",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: ()async{

            if(_depositController.text != null && _depositController
                .text != ''){

              double newBalance = balance - double.tryParse
                (_depositController.text);
              if(newBalance.isNegative){
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text("Insufficient balance"),
                ));
              }else{
                dbHelper.deposit(newBalance, _username);
                setState(() {
                  _isPageLoading = true;
                  getBalance();
                });
              }
            }else{
              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Invalid amount"),));
            }

            },
          ),
        ],
      ),
    );
  }
}
