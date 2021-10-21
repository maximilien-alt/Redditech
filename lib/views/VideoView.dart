import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'chewie_list_item.dart';

class VideoView extends StatelessWidget {
  final String thumbnail;
  final String url;
  BuildContext context_;

  VideoView(
      {required this.thumbnail, required this.url, required this.context_});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.network(thumbnail, fit: BoxFit.fill),
          Positioned(
            width: MediaQuery.of(context).size.width * 0.33,
            height: MediaQuery.of(context).size.height * 0.1,
            child: IconButton(
              icon: Icon(
                Icons.play_arrow,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
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
                                  child: ChewieListItem(
                                    videoPlayerController:
                                        VideoPlayerController.network(this.url),
                                    looping: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
