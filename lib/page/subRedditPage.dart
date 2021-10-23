import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class SubRedditPage extends StatefulWidget {
  SubRedditPage(this.subReddit, {required this.avatarTag});

  final subReddit;
  final Object avatarTag;

  @override
  _SubRedditPageState createState() => new _SubRedditPageState();
}

class _SubRedditPageState extends State<SubRedditPage> {
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
        Image.network(
          widget.subReddit["header_img"] == null
              ? "data:image/png;base64,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"
              : widget.subReddit["header_img"],
          width: MediaQuery.of(context).size.width,
          height: 280.0,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: new Column(
            children: <Widget>[
              Hero(
                tag: widget.avatarTag,
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                      "data:image/jpeg;base64,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"),
                  radius: 50.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text("${widget.subReddit["subscribers"]} subscribers"),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: DecoratedBox(
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.white30),
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  child: createPillButton('SUBSCRIBE',
                      textColor: Colors.white70, onPressed: () {}),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.subReddit["display_name_prefixed"],
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: Colors.white),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(
            widget.subReddit["description"],
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          const Color(0xFF413070),
          const Color(0xFF2B264A),
        ],
      ),
    );

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildHeader(),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: buildBody(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
