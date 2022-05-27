import 'package:flutter/cupertino.dart';
import 'package:test_app/screens/calls.dart';
import 'package:test_app/screens/chats.dart';
import 'package:test_app/screens/people.dart';
import 'package:test_app/screens/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: HomePage(),
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF08C187),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final screens = [
    Chats(),
    Calls(),
    People(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              label: 'Chats',
              icon: Icon(
                CupertinoIcons.chat_bubble_2_fill,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Calls',
              icon: Icon(CupertinoIcons.phone),
            ),
            BottomNavigationBarItem(
              label: 'People',
              icon: Icon(CupertinoIcons.person_alt_circle),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(CupertinoIcons.settings_solid),
            ),
          ],
        ),
        tabBuilder: (context, index) {
          return screens[index];
        },
      ),
    );
  }
}
