import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../infos/PostInfos.dart';
import '../RedditAPI.dart';
import '../views/PostView.dart';

class SubRedditPage extends StatefulWidget {
  SubRedditPage(this.name, {required this.avatarTag});

  final String name;
  final Object avatarTag;

  @override
  _SubRedditPageState createState() => new _SubRedditPageState();
}

class _SubRedditPageState extends State<SubRedditPage> {
  PostInfos? subReddit = null;
  PostInfos? allPosts = null;
  RedditAPI callAPI = RedditAPI();
  String dropdownValue = 'new';
  bool subscribed = false;
  int limit = 5;

  Future<void> callRequests(String filter, int limit) async {
    setState(() {
      allPosts = null;
    });
    PostInfos value =
        await callAPI.getPostsFromSubReddit(widget.name, filter, limit);
    setState(() {
      allPosts = value;
    });
  }

  Widget createPillButton(String text,
      {Color backgroundColor = Colors.transparent,
      Color textColor = Colors.white70,
      void Function()? onPressed}) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: new MaterialButton(
        minWidth: 140.0,
        color: backgroundColor,
        textColor: textColor,
        onPressed: onPressed,
        child: new Text(text),
      ),
    );
  }

  Stack buildHeader() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.5,
          child: Image.network(
            subReddit!.data["banner_background_image"].replaceAll("amp;", ""),
            //color: Color(0xBB8338f4),
            width: MediaQuery.of(context).size.width,
            height: 280.0,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: new Column(
            children: <Widget>[
              Hero(
                tag: widget.avatarTag,
                child: subReddit!.data["icon_img"] != null &&
                        subReddit!.data["icon_img"] != ""
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(
                            subReddit!.data["icon_img"].replaceAll("amp;", "")),
                        radius: 50.0,
                      )
                    : CircleAvatar(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "${subReddit!.data["subscribers"]} subscribers",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white30),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: createPillButton(
                      subscribed ? 'UNSUBSCRIBE' : 'SUBSCRIBE',
                      textColor: Colors.white70, onPressed: () {
                    callAPI.subOrUnsubToSubReddit(
                        subscribed ? "unsub" : "sub", subReddit!.data["name"]);
                    setState(() {
                      subscribed = !subscribed;
                    });
                  }),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(color: Colors.white),
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
        //color: Color(0xFF413070),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          subReddit!.data["display_name_prefixed"],
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.black),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(
            subReddit!.data["public_description"],
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ],
    ));
  }

  Widget buildPosts(BuildContext context) {
    return Column(children: <Widget>[
      Center(
        child: DropdownButton<String>(
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
          items: <String>['new', 'best', 'hot']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
      (allPosts == null ||
              allPosts!.data == null ||
              allPosts!.data["children"] == null ||
              allPosts!.data["children"].length == 0)
          ? Center(child: CircularProgressIndicator())
          : Container(
              //height: MediaQuery.of(context).size.height * 0.389,
              //color: Colors.black87,
              child: Column(
                children: <Widget>[
                  for (var i in allPosts!.data["children"])
                    Column(children: <Widget>[
                      SizedBox(height: 10),
                      PostView(infos: i, box: 0),
                    ])
                ],
              ),
            ),
      //PostView(infos: allPosts!.data["children"][0], box: 0)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    if (subReddit == null) {
      callAPI.getAboutSubReddit(widget.name).then((value) {
        setState(() {
          subReddit = value;
          subscribed = subReddit!.data["user_is_subscriber"];
        });
      });
      callRequests("new", limit);
      return Center(child: CircularProgressIndicator());
    }
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[Colors.blue, Colors.blueAccent],
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: linearGradient,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildHeader(),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: buildBody(context),
              ),
              buildPosts(context),
              //Padding(
              //  padding: const EdgeInsets.all(24.0),
              //  child: buildPosts(context),
              //),
            ],
          ),
        ),
      ),
    );
  }
}
