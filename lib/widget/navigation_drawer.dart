import 'package:atm/model/logout.dart';
import 'package:atm/screens/Withdraw.dart';
import 'package:atm/screens/dashboard.dart';
import 'package:atm/screens/deposit.dart';
import 'package:atm/screens/login.dart';
import 'package:atm/screens/transfer.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Dashboard"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Dashboard();
              }));
            },
          ),
          ListTile(
              title: Text("Deposit"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Deposit();
                }));
              }),
          ListTile(
              title: Text("Transfer"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Transfer();
                }));
              }),
          ListTile(
              title: Text("Withdraw"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Withdraw();
                }));
              }),
          ListTile(
            title: Text("Logout"),
            onTap: () async {
              showDialog(context: context,builder: (_){
                return SimpleDialog(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Logging out..."),
                        ),
                      ],
                    ),
                  ],
                );
              });
              if(await LogoutModel.instance.logout()) {
                Navigator.of(context,rootNavigator: true).pop();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return Login();
                }), (_) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
