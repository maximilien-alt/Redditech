import 'dart:ffi';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import '../localStorage.dart';
import "../infos/PostInfos.dart";
import '../RedditAPI.dart';
import 'subRedditPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_image/flutter_image.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String input = "";
  int limit = 10;
  bool searching = false;
  final storage = LocalStorage();
  PostInfos? infos = null;
  var about = [];
  RedditAPI callApi = RedditAPI();

  @override
  void initState() {
    super.initState();
  }

  Future<void> callSearchRequest() async {
    if (infos != null && infos!.data != {}) {
      setState(() {
        infos!.data["children"] = [];
      });
    }
    if (about != [] && about.length > 0) about = [];
    PostInfos result = await callApi.searchForPost(input, limit);
    if (result.data != {}) {
      //  for (int index = 0; index < result.data["children"].length; index += 1) {
      //    print(
      //        "ABOUT: ${result.data["children"][index]["data"]["display_name"]}");
      //    if (result.data["children"][index] == null ||
      //        result.data["children"][index]["data"] == null) continue;
      //    PostInfos nAbout = await callApi.aboutSubReddit(
      //        result.data["children"][index]["data"]["display_name"]);
//
      //    setState(() {
      //      about.add(nAbout);
      //    });
      //    //about.add(nAbout);
      //    //if (about == null) {
      //    //  setState(() {
      //    //    about = nAbout;
      //    //  });
      //    //} else {
      //    //  about!.data.add(nAbout);
      //    //}
      //  }
      setState(() {
        infos = result;
        searching = false;
      });
    }
  }

  Widget buildSubRedditTile(BuildContext context, int index) {
    var subReddit = infos!.data["children"][index]["data"]["subreddit"] != null
        ? infos!.data["children"][index]["data"]["subreddit"]
        : infos!.data["children"][index]["data"];

    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Container(
              child: SubRedditPage(subReddit, avatarTag: index),
            ),
          ),
        );
      },
      leading: Hero(
        tag: index,
        child: subReddit["icon_img"] != null && subReddit["icon_img"] != ""
            ? CircleAvatar(
                backgroundImage: NetworkImageWithRetry(subReddit["icon_img"]))
            : CircleAvatar(),
      ),
      title: Text(subReddit["display_name"]),
      subtitle: Text("${subReddit["subscribers"]} subscribers"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 40,
            color: Colors.white,
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search for something',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.view_carousel)),
                onSubmitted: (String str) {
                  setState(() {
                    searching = true;
                    input = str;
                    callSearchRequest();
                  });
                },
              ),
            ),
          ),
        ),
        body: infos != null &&
                infos!.data != {} &&
                infos!.data["children"] != null &&
                infos!.data["children"]!.length > 0
            ? ListView.builder(
                itemCount: infos!.data["children"]!.length,
                itemBuilder: buildSubRedditTile)
            : searching
                ? Center(child: CircularProgressIndicator())
                : Center(child: Text("Make a search")));
  }
}
