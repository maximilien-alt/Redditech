import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:draw/draw.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'nav.dart';
import 'localStorage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final storage = LocalStorage();
  bool isLogin = false;
  String clientId = "AOiKKTiIJxKXB2q68T7tMw";
  String responseType = "code";
  String state = "azertyuiop";
  String redirectUri = "https://www.reddditech.max.com/login-callback";
  String duration = "permanent";
  String scope = "identity";
  late String launchedUrl;

  @override
  void initState() {
    super.initState();
    refreshLoginState();
    launchedUrl =
        "https://www.reddit.com/api/v1/authorize?client_id=$clientId&response_type=$responseType&state=$state&redirect_uri=$redirectUri&duration=$duration&scope=$scope";
  }

  Future<void> refreshLoginState() async {
    isLogin = await storage.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      //Navigator.push(context, MaterialPageRoute(builder: (context) {
      //  return Nav();
      //}));
      return Nav();
    } else {
      //refreshLoginState();
      return Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hello There!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Automatic identity verification which enable you to verify your identity",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700], fontSize: 15),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/Reddit-Logo.wine.png'))),
                ),
                Column(
                  children: [
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        launchInBrowser(launchedUrl);
                      },
                      color: Colors.indigoAccent[400],
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white70),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}

Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "could'nt launch $url";
  }
}
