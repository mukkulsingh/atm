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
              if (await LogoutModel.instance.logout()) {
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
