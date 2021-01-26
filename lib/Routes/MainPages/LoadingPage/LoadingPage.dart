import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SplashScreen(
        seconds: 5,
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
