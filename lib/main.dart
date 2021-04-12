import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/Routes/MainPages/ChatPage/ChatPage.dart';
import 'package:socialmedia/Routes/MainPages/ChatPage/ChatRoom.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';
import 'package:socialmedia/Routes/UIElements/GraphicsViewer.dart';
import 'package:socialmedia/Routes/MainPages/LoadingPage/LoadingPage.dart';
import 'package:socialmedia/Routes/MainPages/IntroductionPage/LoginPage.dart';
import 'package:socialmedia/Routes/MainPages/IntroductionPage/SignUpPage.dart';
import 'package:socialmedia/Routes/MainPages/IntroductionPage/IntroductionPage.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/feedPage.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/ProfilePage.dart';
import 'package:socialmedia/Routes/MainPages/SearchPage/SearchPage.dart';
import 'package:socialmedia/Routes/MainPages/MusicPage/MusicPage.dart';
import 'package:socialmedia/Routes/MainPages/CryptoPage/CryptoPage.dart';
import 'package:socialmedia/Routes/MainPages/CryptoPage/CryptoIconViewer.dart';
import 'package:socialmedia/Routes/MainPages/SettingsPage/SettingsPage.dart';

void main() {
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  Future<void> initializeDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkMode = prefs.getBool("DarkModeValue")!;
    // ignore: unnecessary_null_comparison
    if (darkMode == null) {
      darkMode = true;
      prefs.setBool("DarkModeValue", true);
    }
    DesignElements de = DesignElements();
    de.getDarkModeValue();
  }

  @override
  void initState() {
    super.initState();
    initializeDarkMode();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => LoadingPage(),
        "introductionPage": (context) => IntroductionPage(),
        "signUpPage": (context) => SignUpPage(),
        "loginPage": (context) => LoginPage(),
        "homePage": (context) => Home(),
        "chatRoom": (context) => ChatRoom(),
        "feedPage": (context) => FeedPage(),
        "graphicsViewer": (context) => GraphicsViewer(),
        "profilePage": (context) => ProfilePage(),
        "searchPage": (context) => SearchPage(),
        "musicPage": (context) => MusicPage(),
        "cryptoPage": (context) => CryptoPage(),
        "cryptoIconViewer": (context) => CryptoIconViewer(),
        "settingsPage": (context) => SettingsPage(),
      },
    );
  }
}
