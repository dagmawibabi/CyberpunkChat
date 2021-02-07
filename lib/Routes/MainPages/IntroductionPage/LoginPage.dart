import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socialmedia/Routes/Services/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool loginError = false;
  String errorMessage;

  void initialize() async {
    await Firebase.initializeApp();
  }

  void loggedIn(value) async {
    if (value[0] == false) {
      isLoading = false;
      loginError = true;
      errorMessage = value[1].message;
      setState(() {});
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", true);
      prefs.setString("email", emailController.text);
      prefs.setString("password", passwordController.text);
      isLoading = false;
      setState(() {});
      Navigator.pushReplacementNamed(context, "homePage");
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/introscreen/5.png",
                    ),
                    radius: 100.0,
                  ),
                  SizedBox(height: 30.0),
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
                  SizedBox(height: 10.0),
                  // SIGN IN BUTTON
                  Hero(
                    tag: "loginBtn",
                    child: Stack(
                      children: [
                        CustomPaint(
                          painter: DentContainer(
                            108.0,
                            48.0,
                            14.0,
                            10.0,
                            Colors.blue,
                            PaintingStyle.stroke,
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                              fontFamily: DesignElements.tirtiaryFont,
                            ),
                          ),
                          onPressed: () {
                            AuthMethods auth = AuthMethods();
                            auth
                                .signIn(emailController.text,
                                    passwordController.text)
                                .then((value) => loggedIn(value));
                            setState(() {
                              isLoading = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // Error Message
                  loginError == true
                      ? Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: DesignElements.tirtiaryFont,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ));
  }
}
