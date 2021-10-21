import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../localStorage.dart';
import 'package:intl/intl.dart';
import '../infos/PostInfos.dart';

class ImageView extends StatelessWidget {
  final String thumbnail;
  final String url;
  BuildContext context_;

  ImageView(
      {required this.thumbnail, required this.url, required this.context_});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      child: Image.network(thumbnail, fit: BoxFit.fill),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Container(
                  color: Colors.transparent,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                    ),
                    body: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                          Container(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)),
                              child: Image.network(
                                url,
                                fit: BoxFit.fill,
                                height: 400.0,
                              ),
                            ),
                          )
                        ])),
                  ),
                )));
        //Navigator.push(
        //  context,
        //  MaterialPageRoute(
        //    builder: (context) => Center(
        //      child: Image.network(infos["data"]["thumbnail"]),
        //    ),
        //  ),
        //);
      },
    ));
  }
}
