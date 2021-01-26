import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesignElements {
  static Color black;
  static Color grey;
  static Color yellow;
  static bool darkModeValue;

  Future<void> getDarkModeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    darkModeValue = prefs.getBool("DarkModeValue");
    changeTheme();
  }

  void changeTheme() {
    if (darkModeValue == true) {
      black = Colors.black;
      grey = Colors.grey[200];
      yellow = Color.fromRGBO(248, 239, 5, 1);
    } else {
      black = Colors.grey[200];
      grey = Colors.black;
      yellow = Color.fromRGBO(248, 239, 5, 1);
    }
  }

  static String mainFont = "Blanka";
  static String secondaryFont = "BlenderProBook";
  static String tirtiaryFont = "BlenderProBold";

  static Color scaffoldBG = Colors.grey[700];
  static Color scaffoldBodyText = black;

  static Color appBarBG = black;
  static Color appBarTitle = grey;
  static Color appBarIcons = black;
  static double appBarTitleFontSize = 16.0;
  static double appBarTitleLetterSpacing = 2.0;

  static Color fabFG = grey;
  static Color fabBG = black;
  static Color fabIcons = grey;

  static Color bottomNavBarBG = black;
  static Color bottomNavBarIcons = grey;
}
