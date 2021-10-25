import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../localStorage.dart';
import 'package:intl/intl.dart';
import '../infos/PostInfos.dart';
import 'chewie_list_item.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageView extends StatefulWidget {
  final String thumbnail;
  final String url;
  final BuildContext context_;
  final int type;
  final post;
  final int current;
  var urls = [];
  ImageView(
      {Key? key,
      required this.thumbnail,
      required this.url,
      required this.context_,
      required this.type,
      required this.post,
      required this.current})
      : super(key: key) {
    this.urls = [];
    if (type == 1) return;
    for (int index = 0;
        index < post["gallery_data"]["items"].length;
        index += 1) {
      String id = post["gallery_data"]["items"][index]["media_id"];
      urls.add(post["media_metadata"][id]["p"]
              [post["media_metadata"][id]["p"].length - 1]["u"]
          .replaceAll("amp;", ""));
    }
  }

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  int _current = 0;
  bool _stateChange = false;

  @override
  void initState() {
    super.initState();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 1) {
      return Container(
          child: InkWell(
        child: Image.network(widget.thumbnail.replaceAll("amp;", ""),
            fit: BoxFit.fill),
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
                                  widget.url,
                                  fit: BoxFit.fill,
                                  height: 400.0,
                                ),
                              ),
                            )
                          ])),
                    ),
                  )));
        },
      ));
    }
    //_current = (_stateChange == false) ? widget.current : _current;
    return Container(
        child: InkWell(
      child: Image.network(
          widget.post["media_metadata"]
                  [widget.post["gallery_data"]["items"][0]["media_id"]]["p"][0]
                  ["u"]
              .replaceAll("amp;", ""),
          fit: BoxFit.fitWidth),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Container(
                color: Colors.transparent,
                child: new Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      //title: const Text('Transaction Detail'),
                    ),
                    body: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CarouselSlider(
                            options: CarouselOptions(
                                autoPlay: false,
                                height:
                                    MediaQuery.of(context).size.height / 1.3,
                                viewportFraction: 1.0,
                                onPageChanged: (index, data) {
                                  setState(() {
                                    _stateChange = true;
                                    _current = index;
                                  });
                                },
                                initialPage: widget.current),
                            items: map<Widget>(widget.urls, (index, url) {
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0.0)),
                                        child: Image.network(
                                          url,
                                          fit: BoxFit.fill,
                                          height: 400.0,
                                        ),
                                      ),
                                    )
                                  ]);
                            }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: map<Widget>(widget.urls, (index, url) {
                              return Container(
                                width: 10.0,
                                height: 9.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (_current == index)
                                      ? Colors.redAccent
                                      : Colors.grey,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    )))));
      },
    ));
  }
}
