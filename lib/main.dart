import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_app/screens/calls.dart';
import 'package:test_app/screens/chats.dart';
import 'package:test_app/screens/people.dart';
import 'package:test_app/screens/settings_screen.dart';

const useEmulator = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (useEmulator) {
    _connectToFirebaseEmulator();
  }
  runApp(const MyApp());
}

void _connectToFirebaseEmulator() async {
  const firestorePort = 8089;
  const authPort = 9009;
  final localhost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  FirebaseFirestore.instance.settings = Settings(
    host: '$localhost:$firestorePort',
    sslEnabled: false,
    persistenceEnabled: false,
  );
  await FirebaseAuth.instance.useAuthEmulator(localhost, authPort);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: HomePage(),
      theme: CupertinoThemeData(
        brightness: Brightness.light,
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
    SettingsScreen(),
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
