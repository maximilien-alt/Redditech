import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String clientId = "AOiKKTiIJxKXB2q68T7tMw";
  String redirectUri = "http://www.reddit.com";
  String duration = "permanent";
  String codeStr = "code";
  String scopes =
      "identity edit flair history modconfig modflair modlog modposts modwiki mysubreddits privatemessages read report save submit subscribe vote wikiedit wikiread";

  String randomStr = "azertyuiop";
  String data = "";

  @override
  void initState() {
    super.initState();
    getData().then((String result) {
      print("result: $result");
      setState(() {
        data = result;
      });
    });
  }

  Future<String> getData() async {
    final url =
        "https://www.reddit.com/api/v1/authorize?client_id=$clientId&response_type=$codeStr&state=$randomStr&redirect_uri=$redirectUri&duration=$duration&scope=$scopes";
    http.Response response = await http.get(Uri.parse(url));
    return response.body.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text(data),
      ),
    );
  }
}
