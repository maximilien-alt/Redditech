import 'package:flutter/material.dart';
import '../localStorage.dart';
import '../login.dart';

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
    _token = await storage.getToken();
    print("TOKEN: $_token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  centerTitle: true,
      //  title: Text('Settings'),
      //),
      body: Center(
        child: Text('Settings Screen: $_token', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
