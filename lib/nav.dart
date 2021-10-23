import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../page/homePage.dart';
import '../page/profilePage.dart';
import '../page/searchPage.dart';
import '../page/settingsPage.dart';
import 'login.dart';
import 'localStorage.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  final storage = LocalStorage();
  int currentTabIndex = 0;
  String _token = "";
  List<Widget> screens = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
    SettingsPage()
  ];

  Future<void> refreshTokenState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _token = pref.getString("token") ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    refreshTokenState();
  }

  void onItemTap(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_token == "" || _token.length == 0) {
      return Login();
    } else {
      return Scaffold(
        body: screens.elementAt(currentTabIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
          currentIndex: currentTabIndex,
          onTap: onItemTap,
        ),
      );
    }
  }
}
