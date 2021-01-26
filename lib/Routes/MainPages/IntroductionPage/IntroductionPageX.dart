import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';

void main() {
  runApp(IntroductionPageX());
}

class IntroductionPageX extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPageX> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          // WELCOME PAGE
          PageViewModel(
            image: CircleAvatar(
              backgroundImage: AssetImage("assets/images/introscreen/14.jpg"),
            ),
            title: "Welcome To Cyberpunk Chat",
            body: "The most futuristic chatting social media out there...",
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontFamily: DesignElements.mainFont,
              ),
              bodyTextStyle: TextStyle(
                color: DesignElements.grey,
                fontFamily: DesignElements.secondaryFont,
              ),
              pageColor: Colors.black,
              imagePadding: EdgeInsets.only(top: 200.0),
              titlePadding: EdgeInsets.only(top: 40.0),
              descriptionPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            ),
          ),
          PageViewModel(
            image: Image.asset("assets/images/introscreen/14.jpg"),
            title: "Let's explore the world!",
            bodyWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    FlatButton(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    CustomPaint(
                      painter: DentContainer(90.0, 48.0, 14.0, 10.0,
                          Colors.blue, PaintingStyle.stroke),
                    ),
                  ],
                ),
                SizedBox(height: 10.0, width: 14.0),
                Stack(
                  children: [
                    CustomPaint(
                      painter: DentContainer(100.0, 48.0, 14.0, 10.0,
                          Colors.purple, PaintingStyle.stroke),
                    ),
                    FlatButton(
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CustomPaint(
                      painter: DentContainer(200.0, 48.0, 14.0, 10.0,
                          Colors.pink, PaintingStyle.stroke),
                    ),
                    FlatButton(
                      child: Text(
                        "SIGN IN AS GUEST",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            decoration: PageDecoration(
              pageColor: Colors.black,
              titleTextStyle: TextStyle(
                fontFamily: DesignElements.secondaryFont,
                color: DesignElements.grey,
              ),
              bodyTextStyle: TextStyle(
                fontFamily: DesignElements.mainFont,
              ),
              imagePadding: EdgeInsets.only(top: 200.0),
              titlePadding: EdgeInsets.only(top: 40.0),
              descriptionPadding: EdgeInsets.only(top: 30.0),
              footerPadding: EdgeInsets.only(left: 90.0, top: 10.0),
            ),
          )
        ],
        dotsDecorator: DotsDecorator(
          activeSize: Size.square(12.0),
          activeColor: Colors.lightBlueAccent,
          size: Size.square(8.0),
        ),
        done: FlatButton(
          child: Text(
            "Back",
            style: TextStyle(
              color: Colors.pink,
            ),
          ),
          onPressed: () {},
        ),
        onDone: () {},
        showSkipButton: true,
        skip: FlatButton(
          child: Text(
            "Skip",
            style: TextStyle(color: Colors.pink),
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "homePage");
          },
        ),
        showNextButton: true,
        next: FlatButton(
          child: Icon(
            Icons.navigate_next_rounded,
            color: Colors.pink,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
