import 'package:flutter/material.dart';
import '../localStorage.dart';
import '../login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../infos/SettingsInfos.dart';
import '../RedditAPI.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _token = "";
  final storage = LocalStorage();
  RedditAPI callAPI = RedditAPI();
  SettingsInfos? settings = null;
  var values = [];

  @override
  void initState() {
    super.initState();
  }

  _SettingsPageState() {
    updateSettings();
  }

  void updateSettings() {
    settings = null;
    callAPI.getSettings().then((value) {
      setState(() {
        settings = value;
        values = [];
        //values.add({'setting': value});
      });
    });
  }

  Widget buildASetting(
      String settingName, bool state, String comment, String id) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                settingName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                value: state,
                onChanged: (value) {
                  state = !state;
                  callAPI.patchSettings(id, value.toString()).then((value) {
                    updateSettings();
                  });
                },
                activeTrackColor: Colors.yellow,
                activeColor: Colors.orangeAccent,
              ),
            ],
          ),
        ),
        Text(comment)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (settings == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings"),
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
          buildASetting(
              "Adult content",
              settings!.over_18,
              "Enable to view adult and NSFW (not safe for work) content in your feed and search results",
              "over_18"),
          buildASetting(
              "Show stylesheets",
              settings!.show_stylesheets,
              "Allow you to see stylesheets inside reddit post",
              "show_stylesheets"),
          buildASetting(
              "Autoplay media",
              settings!.video_autoplay,
              "Play videos and gifs automatically when in the viewport",
              "video_autoplay"),
          buildASetting("Show Twitter", settings!.show_twitter,
              "Allows you to see twitter's reply posts", "show_twitter"),
          buildASetting("Show Trending", settings!.show_trending,
              "Allow you to see trending subreddits", "show_trending"),
          buildASetting(
              "Store visits", settings!.store_visits, "", "store_visits"),
        ],
      ),
    );
  }
}
