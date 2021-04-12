import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
import 'package:socialmedia/Routes/Services/Services.dart';

void main() {
  runApp(SignUpPage());
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  bool loginError = false;
  late String errorMessage;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  void initialize() async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void signUp(value) async {
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
      backgroundColor: Colors.black,
      body: isLoading == false
          ? Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/introscreen/5.png",
                          ),
                          radius: 100.0,
                        ),
                        SizedBox(height: 30.0),
                        // USERNAME
                        Stack(
                          children: [
                            CustomPaint(
                              painter: DentContainer(
                                380.0,
                                58.0,
                                14.0,
                                10.0,
                                Colors.white,
                                PaintingStyle.stroke,
                              ),
                            ),
                            TextField(
                              controller: usernameController,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontFamily: DesignElements.tirtiaryFont,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintText: "USERNAME",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.0),
                        // EMAIL
                        Stack(
                          children: [
                            CustomPaint(
                              painter: DentContainer(
                                380.0,
                                58.0,
                                14.0,
                                10.0,
                                Colors.white,
                                PaintingStyle.stroke,
                              ),
                            ),
                            TextField(
                              controller: emailController,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontFamily: DesignElements.tirtiaryFont,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                ),
                                hintText: "EMAIL",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.0),
                        // PASSWORD
                        Stack(
                          children: [
                            CustomPaint(
                              painter: DentContainer(
                                380.0,
                                58.0,
                                14.0,
                                10.0,
                                Colors.white,
                                PaintingStyle.stroke,
                              ),
                            ),
                            TextField(
                              controller: passwordController,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontFamily: DesignElements.tirtiaryFont,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                ),
                                hintText: "PASSWORD",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.0),
                        // CONFIRM PASSWORD
                        Stack(
                          children: [
                            CustomPaint(
                              painter: DentContainer(
                                380.0,
                                58.0,
                                14.0,
                                10.0,
                                Colors.white,
                                PaintingStyle.stroke,
                              ),
                            ),
                            TextField(
                              controller: confirmPasswordController,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontFamily: DesignElements.tirtiaryFont,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                ),
                                hintText: "CONFIRM PASSWORD",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        // SIGN UP BUTTON
                        Hero(
                          tag: "signUpBtn",
                          child: Stack(
                            children: [
                              CustomPaint(
                                painter: DentContainer(
                                  130.0,
                                  48.0,
                                  14.0,
                                  10.0,
                                  Colors.purple,
                                  PaintingStyle.stroke,
                                ),
                              ),
                              FlatButton(
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: Colors.white,
                                    fontFamily: DesignElements.tirtiaryFont,
                                  ),
                                ),
                                onPressed: () {
                                  AuthMethods auth = AuthMethods();
                                  auth
                                      .signUp(emailController.text,
                                          passwordController.text)
                                      .then((value) => signUp(value));
                                  setState(() {
                                    isLoading = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        loginError == true
                            ? Text(
                                errorMessage.toString(),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: DesignElements.tirtiaryFont,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
