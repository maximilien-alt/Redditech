import 'package:flutter/material.dart';
import 'package:redditech/views/VideoView.dart';
import 'package:url_launcher/url_launcher.dart';
import '../localStorage.dart';
import 'package:intl/intl.dart';
import '../infos/PostInfos.dart';
import 'ImageView.dart';
import '../RedditAPI.dart';

class PostView extends StatelessWidget {
  final Map<String, dynamic> infos;
  final int box;
  late int type = 0;
  PostView({required this.infos, required this.box}) {
    if (infos["data"]["post_hint"] == "image") {
      this.type = 1;
    } else if (infos["data"]["is_video"]) {
      this.type = 2;
    } else if (infos["data"]["crosspost_parent_list"] != null &&
        infos["data"]["crosspost_parent_list"].length > 0 &&
        infos["data"]["crosspost_parent_list"][0]["secure_media"] != null &&
        infos["data"]["crosspost_parent_list"][0]["secure_media"]
                ["reddit_video"] !=
            null &&
        infos["data"]["crosspost_parent_list"][0]["secure_media"]
                ["reddit_video"]["is_gif"] ==
            true) {
      this.type = 3;
    } else if (infos["data"]["preview"] != null &&
        infos["data"]["preview"]["reddit_video_preview"] != null &&
        infos["data"]["preview"]["reddit_video_preview"]["is_gif"] == true) {
      type = 4;
    } else if (infos["data"]["gallery_data"] != null &&
        infos["data"]["gallery_data"].length > 0) {
      type = 6;
    } else
      this.type = 5;
  }
  RedditAPI callAPI = RedditAPI();

  void vote(String postId, int vote) {
    callAPI.votePost(postId, vote);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.95,
        //height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                SizedBox(width: 5),
                Text(
                  infos["data"]["subreddit_name_prefixed"] +
                      " ° " +
                      DateFormat('dd/MM/yyyy à hh:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              infos["data"]["created"].toInt() * 1000)),
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    infos["data"]["title"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                type >= 2 && type <= 4
                    ? VideoView(
                        thumbnail: infos["data"]["thumbnail"],
                        url: type == 2
                            ? infos["data"]["secure_media"]["reddit_video"]
                                ["fallback_url"]
                            : type == 3
                                ? infos["data"]["crosspost_parent_list"][0]
                                        ["secure_media"]["reddit_video"]
                                    ["fallback_url"]
                                : infos["data"]["preview"]
                                    ["reddit_video_preview"]["fallback_url"],
                        context_: context)
                    : type == 1 || type == 6
                        ? ImageView(
                            thumbnail: infos["data"]["thumbnail"],
                            url: infos["data"]["url_overridden_by_dest"],
                            context_: context,
                            type: type,
                            post: infos["data"],
                            current: 0,
                          )
                        : Expanded(
                            child: Container(
                              height: 120,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    infos["data"]["selftext"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Posts'),
                                  ),
                                ),
                              ),
                            ),
                          ),
              ],
            ),
          ],
        ));
  }
}
