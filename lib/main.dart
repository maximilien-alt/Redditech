import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redditech/login.dart';
import 'nav.dart';
import 'package:uni_links/uni_links.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localStorage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

void callTokenRequest(String code) async {
  String redirectUri = "https://www.reddditech.max.com/login-callback";
  String clientId = "AOiKKTiIJxKXB2q68T7tMw";
  String password = "";
  String grant_type = "authorization_code";
  String basicAuth =
      "Basic " + base64Encode(utf8.encode("$clientId:$password"));
  final response = await http.post(
    Uri.parse("https://www.reddit.com/api/v1/access_token"),
    headers: <String, String>{
      'authorization': basicAuth,
    },
    body: <String, String>{
      'grant_type': grant_type,
      'code': code,
      'redirect_uri': redirectUri
    },
  );
  print("response: ${response.statusCode}, code: $code");
  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    String token = json["access_token"];
    SharedPreferences.getInstance().then((SharedPreferences value) {
      value.setString("token", token);
      print("TOKEN: $token");
    });
    //json["access_token"];
  }
}

class MyApp extends StatelessWidget {
  final storage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        stream: getLinksStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var uri = Uri.parse(snapshot.data.toString());
            var list = uri.queryParametersAll.entries.toList();
            // ignore: unused_local_variable
            for (var i = 0; i < list.length; i += 1) {
              if (list[i].key == "code") {
                callTokenRequest(list[i].value[0]);
                break;
              }
            }
          }
          return Login();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
