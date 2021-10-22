import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../localStorage.dart';
import '../login.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        child: Text('Search Screen: $_token', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
