import 'package:flutter/material.dart';
import 'package:redditech/infos/PostInfos.dart';
import 'package:redditech/localStorage.dart';
import '../login.dart';
import '../localStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../RedditAPI.dart';
import '../views/PostView.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _token = "";
  RedditAPI callAPI = RedditAPI();
  PostInfos? allSubReddits;
  List<PostInfos> allPosts = List.empty();

  @override
  void initState() {
    super.initState();
    refreshTokenState();
    //print("TOKEN: $_token");
  }

  _HomePageState() {
    callAPI.getMySubReddits().then((PostInfos sub) {
      setState(() {
        allSubReddits = sub;
        callAPI
            .getPostsFromSubReddit(
                allSubReddits!.data["children"][3]["data"]["display_name"], "")
            .then((PostInfos value) {
          allPosts[0] = value;
        });
        //for (int index = 0;
        //    index < allSubReddits!.data["children"]!.length;
        //    index += 1) {
        //  print(
        //      "NAME: ${allSubReddits!.data["children"][index]["data"]["display_name"]}");
        //  callAPI
        //      .getPostsFromSubReddit(
        //          allSubReddits!.data["children"][index]["data"]
        //              ["display_name"],
        //          "")
        //      .then((PostInfos value) {
        //    allPosts.add(value);
        //  });
        //}
      });
    });
  }

  Future<void> refreshTokenState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _token = pref.getString("token") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    //if ()
    return Container(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
                child: Column(children: <Widget>[
              for (PostInfos i in allPosts[index].data["children"])
                PostView(infos: allPosts[index].data["children"][i], box: 0)
              //SizedBox(height: index == 0 ? 0 : 10),
            ]));
          }, childCount: allPosts.length),
        ),
      ],
    ));
  }
}
