import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/Routes/Services/Services.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
import 'package:socialmedia/Routes/MainPages/IntroductionPage/PageTransitionDots.dart';

void main() {
  runApp(IntroductionPage());
}

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  bool isLoading = false;
  bool loginError = false;
  String errorMessage;

  Color activeColor = Colors.lightBlue;
  Color inactiveColor = Colors.pink[700];
  PaintingStyle activePaintingStyle = PaintingStyle.fill;
  PaintingStyle inactivePaintingStyle = PaintingStyle.stroke;
  PageController pageController = PageController();
  void initialize() async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void signInAnonymous(value) async {
    print(value);
    if (value[0] == false) {
      isLoading = false;
      loginError = true;
      errorMessage = value[1].message;
      setState(() {});
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", true);
      isLoading = false;
      setState(() {});
      Navigator.pushReplacementNamed(context, "homePage");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "CYBERPUNK",
          style: TextStyle(
            fontSize: 16.0,
            letterSpacing: 4.0,
            color: Colors.white,
            fontFamily: DesignElements.mainFont,
          ),
        ),
        actions: [
          FlatButton(
            child: Text(
              "R",
              style: TextStyle(
                color: Colors.pink,
              ),
            ),
            onPressed: () {
              setState(() {});
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 20.0),
            child: FlatButton(
              child: Text(
                "Skip",
                style: TextStyle(
                  color: Colors.pink,
                ),
              ),
              onPressed: () {
                pageController.animateToPage(
                  2,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: PageView(
          controller: pageController,
          children: [
            // PAGE 1 - WELCOME PAGE
            Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  //IMAGE
                  CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/introscreen/14.png"),
                    radius: 120.0,
                  ),
                  SizedBox(height: 40.0),
                  // TITLE AND BODY
                  Column(
                    children: [
                      Text(
                        "WELCOME TO CYBERPUNK CHAT",
                        style: TextStyle(
                          color: DesignElements.grey,
                          fontSize: 14.0,
                          letterSpacing: 1.0,
                          fontFamily: DesignElements.tirtiaryFont,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "The most futuristic social media platform out there!",
                        style: TextStyle(
                          color: DesignElements.grey,
                          fontFamily: DesignElements.secondaryFont,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  // DOTS AND NEXT BUTTON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PageTransitionProgressDots(
                          activeIndex: 1,
                          activeColor: activeColor,
                          activePaintingStyle: activePaintingStyle,
                          inactiveColor: inactiveColor,
                          inactivePaintingStyle: inactivePaintingStyle),
                      Spacer(),
                      FlatButton(
                        onPressed: () {
                          pageController.animateToPage(
                            1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear,
                          );
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // PAGE 2 - WELCOME PAGE
            Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  //IMAGE
                  CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/introscreen/14.png"),
                    radius: 120.0,
                  ),
                  SizedBox(height: 40.0),
                  // TITLE AND BODY
                  Column(
                    children: [
                      Text(
                        "WELCOME TO CYBERPUNK CHAT",
                        style: TextStyle(
                          color: DesignElements.grey,
                          fontSize: 14.0,
                          letterSpacing: 1.0,
                          fontFamily: DesignElements.tirtiaryFont,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "The most futuristic social media platform out there!",
                        style: TextStyle(
                          color: DesignElements.grey,
                          fontFamily: DesignElements.secondaryFont,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  // DOTS AND NEXT BUTTON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PageTransitionProgressDots(
                          activeIndex: 2,
                          activeColor: activeColor,
                          activePaintingStyle: activePaintingStyle,
                          inactiveColor: inactiveColor,
                          inactivePaintingStyle: inactivePaintingStyle),
                      Spacer(),
                      FlatButton(
                        onPressed: () {
                          pageController.animateToPage(
                            2,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear,
                          );
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // PAGE 3 - WELCOME PAGE
            Container(
              color: Colors.black,
              width: double.infinity,
              height: double.infinity,
              /*decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/introscreen/14.jpg"),
                  fit: BoxFit.cover,
                ),
              ),*/
              child: isLoading == false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        //IMAGE
                        /*CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/introscreen/14.png"),
                    radius: 120.0,
                  ),*/
                        Image.asset("assets/images/introscreen/14.png"),
                        SizedBox(height: 40.0),
                        // TITLE AND BODY
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 50.0),
                          child: Stack(
                            fit: StackFit.loose,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 20.0),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "LET'S EXPLORE THE WORLD!",
                                      style: TextStyle(
                                        color: DesignElements.grey,
                                        fontSize: 14.0,
                                        letterSpacing: 1.0,
                                        fontFamily: DesignElements.tirtiaryFont,
                                      ),
                                    ),
                                    SizedBox(height: 30.0),
                                    // BUTTONS
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // LOGIN BUTTON
                                            Hero(
                                              tag: "loginBtn",
                                              child: Stack(
                                                children: [
                                                  CustomPaint(
                                                    painter: DentContainer(
                                                      90.0,
                                                      46.0,
                                                      10.0,
                                                      10.0,
                                                      Colors.blue,
                                                      PaintingStyle.stroke,
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    child: Text(
                                                      "LOGIN",
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        color: Colors.white,
                                                        fontFamily:
                                                            DesignElements
                                                                .tirtiaryFont,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context, "loginPage");
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 20.0),
                                            // SIGN UP BUTTON
                                            Hero(
                                              tag: "signUpBtn",
                                              child: Stack(
                                                children: [
                                                  CustomPaint(
                                                    painter: DentContainer(
                                                      110.0,
                                                      46.0,
                                                      10.0,
                                                      10.0,
                                                      Colors.purple,
                                                      PaintingStyle.stroke,
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    child: Text(
                                                      "SIGN UP",
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        color: Colors.white,
                                                        fontFamily:
                                                            DesignElements
                                                                .tirtiaryFont,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          "signUpPage");
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        // GUEST BUTTON
                                        Stack(
                                          children: [
                                            CustomPaint(
                                              painter: DentContainer(
                                                220.0,
                                                46.0,
                                                10.0,
                                                10.0,
                                                Colors.pink,
                                                PaintingStyle.stroke,
                                              ),
                                            ),
                                            FlatButton(
                                              child: Text(
                                                "BROWSE AS GUEST",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.white,
                                                  fontFamily: DesignElements
                                                      .tirtiaryFont,
                                                ),
                                              ),
                                              onPressed: () {
                                                AuthMethods auth =
                                                    AuthMethods();
                                                auth.signInAnonymous().then(
                                                    (value) =>
                                                        signInAnonymous(value));
                                                setState(() {
                                                  isLoading = true;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                child: CustomPaint(
                                  painter: DentContainer(
                                    310.0,
                                    200.0,
                                    30.0,
                                    10.0,
                                    Colors.pink,
                                    PaintingStyle.stroke,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        loginError == true
                            ? Text(
                                errorMessage,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: DesignElements.tirtiaryFont,
                                ),
                              )
                            : Container(),
                        // DOTS AND NEXT BUTTON
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PageTransitionProgressDots(
                                activeIndex: 3,
                                activeColor: activeColor,
                                activePaintingStyle: activePaintingStyle,
                                inactiveColor: inactiveColor,
                                inactivePaintingStyle: inactivePaintingStyle),
                            Spacer(),
                            FlatButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, "homePage");
                              },
                              child: Text(
                                "Done",
                                style: TextStyle(
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
