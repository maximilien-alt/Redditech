import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import '../localStorage.dart';
import "../infos/PostInfos.dart";
import '../RedditAPI.dart';
import 'subRedditPage.dart';

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
  RedditAPI callApi = RedditAPI();

  @override
  void initState() {
    super.initState();
  }

  Future<void> callSearchRequest() async {
    if (infos != null && infos!.data != {}) infos!.data["children"] = [];
    PostInfos result = await callApi.searchForPost(input, limit);
    if (result.data != {}) {
      setState(() {
        infos = result;
        searching = false;
      });
    }
  }

  Widget buildSubRedditTile(BuildContext context, int index) {
    var subReddit = infos!.data["children"][index]["data"];

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
        child: CircleAvatar(
          backgroundImage: NetworkImage(subReddit["header_img"] == null
              ? "data:image/png;base64,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"
              : subReddit["header_img"]),
        ),
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
