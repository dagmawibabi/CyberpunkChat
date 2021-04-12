import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/Routes/Services/Services.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:socialmedia/Routes/MainPages/IntroductionPage/IntroductionPage.dart';

void main() {
  runApp(LoadingPage());
}

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    //initialize();
    //isLoggedIn();
  }

  void initialize() async {
    await Firebase.initializeApp();
  }

  void isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isIn = prefs.getBool("isLoggedIn")!;
    String email = prefs.getString("email")!;
    String password = prefs.getString("password")!;
    if (isIn) {
      AuthMethods auth = AuthMethods();
      auth.signIn(email, password).then((value) => print(value));
      Navigator.pushReplacementNamed(context, "homePage");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SplashScreen(
        seconds: 3,
        title: Text(
          "Cyberpunk",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontFamily: "Blanka",
          ),
        ),
        //backgroundColor: Color.fromRGBO(248, 239, 5, 1),
        imageBackground: AssetImage("assets/images/77.jpg"),

        loadingText: Text(
          "Loading...",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontFamily: "BlenderProBold",
          ),
        ),
        loaderColor: Colors.black,
        navigateAfterSeconds: IntroductionPage(),
      ),
    );
  }
}
