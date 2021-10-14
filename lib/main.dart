import 'package:flutter/material.dart';
import 'package:redditech/login.dart';
import 'nav.dart';
import 'package:uni_links/uni_links.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localStorage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final storage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        stream: getLinksStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var uri = Uri.parse(snapshot.data.toString());
            var list = uri.queryParametersAll.entries.toList();
            // ignore: unused_local_variable
            for (var i = 0; i < list.length; i += 1) {
              if (list[i].key != "code") continue;
              storage.setToken(list[i].value[0]);
            }
          }
          return Login();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
