import 'package:flutter/material.dart';
import '../login.dart';
import '../localStorage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      //  title: Text('Profile'),
      //),
      body: Text('Profile Page: $_token'),
    );
  }
}
