import 'package:flutter/material.dart';
import 'package:redditech/localStorage.dart';
import '../login.dart';
import '../localStorage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      //  title: Text('Home'),
      //),
      body: Center(
        child: Text('Home Screen: $_token', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
