import 'package:atm/database/database_helper.dart';
import 'package:atm/model/saved_preference_model.dart';
import 'package:atm/widget/navigation_drawer.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final dbHelper = DatabaseHelper.instance;

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  static double balance=0;
  static bool _isPageLoading;

  void getBalance()async{
    String username = await SavedPreferenceModel.instance.getUserName();
    balance = await dbHelper.getBalance(username);
    setState(() {
      _isPageLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _isPageLoading = true;
    getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Dashboard"),

      ),
      drawer: NavigationDrawer(),
      body: _isPageLoading?Center(
        child: CircularProgressIndicator(),
      ):Container(
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
    );
  }
}
