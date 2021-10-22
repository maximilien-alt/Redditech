import 'package:flutter/material.dart';
import 'package:redditech/infos/PostInfos.dart';
import 'package:redditech/infos/ProfileInfos.dart';
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
  final storage = LocalStorage();
  RedditAPI callAPI = RedditAPI();
  PostInfos? allSubReddits;
  PostInfos? allPosts = null;
  List<PostInfos> postList = List.empty();
  String dropdownValue = 'new';
  int limit = 5;

  @override
  void initState() {
    super.initState();
    //print("TOKEN: $_token");
  }

  _HomePageState() {
    callRequests("new", limit);
  }

  Future<void> callRequests(String filter, int limit) async {
    if (allPosts != null) {
      allPosts!.data["children"] = [];
    }
    PostInfos sub = await callAPI.getMySubReddits();
    for (int index = 0; index < sub.data["children"].length; index += 1) {
      PostInfos value = await callAPI.getPostsFromSubReddit(
          sub.data["children"][index]["data"]["display_name"], filter, limit);
      if (allPosts == null) {
        setState(() {
          allPosts = value;
        });
      } else {
        if (value == null ||
            value.data == null ||
            value.data["children"] == null) continue;
        for (int i = 0; i < value.data["children"].length; i += 1) {
          setState(() {
            allPosts!.data["children"].add(value.data["children"][i]);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (allPosts == null ||
        allPosts!.data == null ||
        allPosts!.data["children"] == null ||
        allPosts!.data["children"].length == 0)
      return Center(child: CircularProgressIndicator());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down_outlined),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    callRequests(dropdownValue, limit);
                  });
                },
                items: <String>['new', 'best', 'hot', 'random']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Text("Home"),
              GestureDetector(
                onTap: () {
                  storage.deleteToken();
                },
                child: Icon(Icons.logout),
              ),
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                    child: Column(children: <Widget>[
                  //for (PostInfos i in allPosts[index].data["children"])
                  SizedBox(height: index == 0 ? 0 : 10),
                  PostView(infos: allPosts!.data["children"][index], box: 0)
                ]));
              },
                  childCount: allPosts != null &&
                          allPosts!.data != null &&
                          allPosts!.data["children"] != null
                      ? allPosts!.data["children"]!.length
                      : 0),
            ),
          ],
        ));
  }
}
