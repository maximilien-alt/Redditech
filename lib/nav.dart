import 'package:flutter/material.dart';
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
  final List<Widget> screens = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
    SettingsPage()
  ];

  Future<void> refreshTokenState() async {
    _token = await storage.getToken();
    print("TOKEN: $_token");
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
        appBar: AppBar(
          centerTitle: true,
          title: Text(currentTabIndex == 0
              ? "Home"
              : currentTabIndex == 1
                  ? "Search"
                  : currentTabIndex == 2
                      ? "Profile"
                      : "Settings"),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  storage.deleteToken();
                },
                child: Icon(Icons.logout),
              ),
            ),
          ],
        ),
        body: screens.elementAt(currentTabIndex),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
