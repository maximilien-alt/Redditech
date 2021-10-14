import 'package:flutter/material.dart';
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
    _token = await storage.getToken();
    print("TOKEN: $_token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  centerTitle: true,
      //  title: Text('Search'),
      //),
      body: Center(
        child: Text('Search Screen: $_token', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
