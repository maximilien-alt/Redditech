import 'package:flutter/material.dart';
import '../localStorage.dart';
import '../login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _token = "";
  final storage = LocalStorage();

  @override
  void initState() {
    super.initState();
    refreshTokenState();
    //print("TOKEN: $_token");
  }

  Future<void> refreshTokenState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _token = pref.getString("token") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                storage.deleteToken();
              },
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('Settings Screen: $_token', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
