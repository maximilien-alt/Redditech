import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'infos/ProfileInfos.dart';
import 'infos/PostInfos.dart';

class RedditAPI {
  RedditAPI();

  Future<ProfileInfos> getProfileInfos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "https://oauth.reddit.com/api/v1/me";
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Authorization': 'bearer ' + prefs.getString("token")!,
    });
    if (response.statusCode == 200) {
      return ProfileInfos.fromJson(jsonDecode(response.body));
    } else {
      return ProfileInfos("name", {}, 0, "icon_img", 0);
    }
  }

  Future<PostInfos> getAllPosts(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "https://oauth.reddit.com/user/" + username + "/submitted";
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Authorization': 'bearer ' + prefs.getString("token")!,
    });
    if (response.statusCode == 200) {
      return PostInfos.fromJson(jsonDecode(response.body));
    } else {
      return PostInfos({});
    }
  }
}
