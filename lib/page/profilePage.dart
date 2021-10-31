import 'package:flutter/material.dart';
import 'package:redditech/infos/PostInfos.dart';
import 'package:redditech/infos/ProfileInfos.dart';
import '../login.dart';
import '../localStorage.dart';
import '../RedditAPI.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../views/PostView.dart';

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
  PostInfos? postInfos;

  _ProfilePageState() {
    callAPI.getProfileInfos().then((ProfileInfos value) {
      setState(() {
        infos = value;
      });
      callAPI.getAllPosts(infos!.name).then((PostInfos post) {
        setState(() {
          print("DATA: $post");
          postInfos = post;
        });
      });
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
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile"),
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
        body: Column(
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Image.network(
                    infos!.subreddit["banner_img"].replaceAll("amp;", "")),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.085,
                  left: MediaQuery.of(context).size.width * 0.01,
                  child: Container(
                    //padding: EdgeInsets.only(top: ),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Align(
                      child: Row(
                        verticalDirection: VerticalDirection.down,
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
                                side:
                                    BorderSide(width: 5, color: Colors.white)),
                            child: Center(
                              child: Image.network(infos!.subreddit["icon_img"]
                                  .replaceAll("amp;", "")),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
              ],
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(width: 50),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Karma",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.grey,
                            size: 12,
                          ),
                          Text(
                            "${infos!.total_karma}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Cake day",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              infos!.created.toInt() * 1000)),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 70),
            Column(children: <Widget>[
              Text(
                infos!.subreddit["public_description"],
                style: TextStyle(fontSize: 15, color: Colors.blue, shadows: [
                  Shadow(
                      color: Colors.grey, offset: Offset(1, 1), blurRadius: 2)
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.blue),
                    onPressed: () {},
                    child: Text(
                      infos!.subreddit['subscribers'].toString() +
                          ((infos!.subreddit['subscribers'] <= 1)
                              ? " subscriber"
                              : " subscribers"),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.black,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.389,
                color: Colors.black87,
                child: DefaultTabController(
                  length: 1,
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.blueAccent,
                      toolbarHeight: MediaQuery.of(context).size.height * 0.05,
                      flexibleSpace: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TabBar(
                            indicatorColor: Colors.white,
                            indicatorWeight: 1,
                            tabs: [
                              Text("Posts"),
                            ],
                          )
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        Container(
                            child: CustomScrollView(
                          slivers: <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Container(
                                    child: Column(children: <Widget>[
                                  SizedBox(height: index == 0 ? 0 : 10),
                                  PostView(
                                      infos: postInfos!.data["children"][index],
                                      box: index)
                                ]));
                              },
                                  childCount: postInfos == null
                                      ? 0
                                      : postInfos!.data["children"]!.length),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ));
  }
}
