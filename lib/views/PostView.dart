import 'package:flutter/material.dart';
import 'package:redditech/views/VideoView.dart';
import 'package:url_launcher/url_launcher.dart';
import '../localStorage.dart';
import 'package:intl/intl.dart';
import '../infos/PostInfos.dart';
import 'ImageView.dart';

class PostView extends StatelessWidget {
  final Map<String, dynamic> infos;
  final int box;
  PostView({required this.infos, required this.box});

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
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        //height: 50,
        child: Column(
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
                Text(
                  infos["data"]["title"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            infos["data"]["is_video"]
                ? VideoView(
                    thumbnail: infos["data"]["thumbnail"],
                    url: infos["data"]["secure_media"]["reddit_video"]
                        ["fallback_url"],
                    context_: context)
                : infos["data"]["post_hint"] == "image"
                    ? ImageView(
                        thumbnail: infos["data"]["thumbnail"],
                        url: infos["data"]["url_overridden_by_dest"],
                        context_: context)
                    : InkWell(
                        child: infos["data"]["selftext"].contains("https")
                            ? Text(
                                infos["data"]["selftext"].substring(14),
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            : Text(infos["data"]["selftext"]),
                        onTap: () {
                          if (infos["data"]["selftext"].contains("https"))
                            launch(infos["data"]["selftext"].substring(14));
                        }),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_upward,
                  size: 20,
                  color: Colors.orange,
                ),
                Text(infos["data"]["ups"].toString()),
                Icon(
                  Icons.arrow_downward,
                  size: 20,
                  color: Colors.black,
                ),
                Text(infos["data"]["downs"].toString()),
              ],
            )
          ],
        ));
  }
}
