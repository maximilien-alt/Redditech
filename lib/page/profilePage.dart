import 'package:flutter/material.dart';
import 'package:redditech/ProfileInfos.dart';
import '../login.dart';
import '../localStorage.dart';
import '../RedditAPI.dart';
import 'dart:async';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _token = "";
  final storage = LocalStorage();
  RedditAPI callAPI = RedditAPI();
  ProfileInfos? infos;

  _ProfilePageState() {
    callAPI.getProfileInfos().then((value) {
      infos = value;
    });
  }

  @override
  void initState() {
    super.initState();
    callAPI.getProfileInfos().then((value) {
      setState(() {
        infos = value;
      });
    });
    //print("TOKEN: $_token");
  }

  @override
  Widget build(BuildContext context) {
    print("HERE");
    if (infos == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        body: Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Image.network(infos!.subreddit["banner_img"].replaceAll("amp;", "")),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            left: MediaQuery.of(context).size.width * 0.03,
            child: FractionallySizedBox(
              child: Container(
                //padding: EdgeInsets.only(top: 1),
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 1,
                child: Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        color: Colors.blueGrey,
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            side: BorderSide(width: 5, color: Colors.white)),
                        child: Center(
                          child: Image.network(infos!.subreddit["icon_img"]
                              .replaceAll("amp;", "")),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.24,
          left: MediaQuery.of(context).size.width * 0.01,
          child: Text(
            infos!.name,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.17,
          left: MediaQuery.of(context).size.width * 0.41,
          child: Text(
            "Karma",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.20,
          left: MediaQuery.of(context).size.width * 0.41,
          child: Text(
            "${infos!.total_karma}",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.17,
          left: MediaQuery.of(context).size.width * 0.71,
          child: Text(
            "Cake day",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    )
        // Image.network(infos!.subreddit["banner_img"].replaceAll("amp;", ""))
        );
  }
}
