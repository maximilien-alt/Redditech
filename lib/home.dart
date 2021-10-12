import 'package:flutter/material.dart';
import '../page/homePage.dart';
import '../page/profilePage.dart';
import '../page/searchPage.dart';
import '../page/settingsPage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTabIndex = 0;
  final List<Widget> screens = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
    SettingsPage()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(child: currentScreen, bucket: bucket),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = HomePage();
                          currentTabIndex = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home,
                              color: currentTabIndex == 0
                                  ? Colors.blue
                                  : Colors.grey),
                          Text(
                            'Home',
                            style: TextStyle(
                                color: currentTabIndex == 0
                                    ? Colors.blue
                                    : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = SearchPage();
                          currentTabIndex = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search,
                              color: currentTabIndex == 1
                                  ? Colors.blue
                                  : Colors.grey),
                          Text(
                            'Search',
                            style: TextStyle(
                                color: currentTabIndex == 1
                                    ? Colors.blue
                                    : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = ProfilePage();
                          currentTabIndex = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.dashboard,
                              color: currentTabIndex == 2
                                  ? Colors.blue
                                  : Colors.grey),
                          Text(
                            'Profile',
                            style: TextStyle(
                                color: currentTabIndex == 2
                                    ? Colors.blue
                                    : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = SettingsPage();
                          currentTabIndex = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings,
                              color: currentTabIndex == 3
                                  ? Colors.blue
                                  : Colors.grey),
                          Text(
                            'Settings',
                            style: TextStyle(
                                color: currentTabIndex == 3
                                    ? Colors.blue
                                    : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
