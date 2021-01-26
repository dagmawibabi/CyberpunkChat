import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(SettingsPage());
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode;
  bool darkModePrivate = true;

  Future<void> getDarkModeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      darkMode = prefs.getBool("DarkModeValue");
      darkModePrivate = darkMode;
    } catch (e) {
      darkMode = true;
      darkModePrivate = true;
    }
    setState(() {});
  }

  Future<void> setDarkModeValue(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("DarkModeValue", value);
    DesignElements de = DesignElements();
    de.getDarkModeValue();
    de.changeTheme();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDarkModeValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignElements.scaffoldBG,
      appBar: AppBar(
        backgroundColor: DesignElements.appBarBG,
        automaticallyImplyLeading: false,
        title: Text(
          "SETTINGS",
          style: TextStyle(
            color: DesignElements.appBarTitle,
            fontSize: DesignElements.appBarTitleFontSize,
            fontFamily: DesignElements.mainFont,
            letterSpacing: DesignElements.appBarTitleLetterSpacing,
          ),
        ),
      ),
      body: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.brightness_2_outlined,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      "DARK MODE",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "BlenderProBold",
                      ),
                    ),
                  ],
                ),
                CupertinoSwitch(
                  activeColor: Colors.black,
                  value: darkModePrivate,
                  onChanged: (newValue) {
                    darkModePrivate = newValue;
                    setDarkModeValue(newValue);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
