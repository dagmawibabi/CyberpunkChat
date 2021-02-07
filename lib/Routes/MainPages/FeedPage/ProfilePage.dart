import 'dart:io';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double dpWidth = 200.0;
  final double dpHeight = 200.0;
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  User currentUser;
  void getUser() {
    final _auth = FirebaseAuth.instance;
    print(_auth.currentUser);
    currentUser = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignElements.appBarBG,
        title: Text(
          "PROFILE",
          style: TextStyle(
            color: DesignElements.appBarTitle,
            fontSize: DesignElements.appBarTitleFontSize,
            fontFamily: DesignElements.mainFont,
            letterSpacing: DesignElements.appBarTitleLetterSpacing,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // PROFILE PIC
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: ClipPath(
                clipper: ProfilePicClipper(dpWidth, dpHeight),
                child: Container(
                  height: dpHeight,
                  child: Stack(
                    children: [
                      CustomPaint(
                        painter: DentContainer(dpWidth, dpHeight, 10.0, 10.0,
                            Colors.black, PaintingStyle.fill),
                      ),
                      Container(
                        width: dpWidth,
                        height: dpHeight,
                        child: Image.asset("assets/images/4.jpg"),
                      ),
                      CustomPaint(
                        painter: DentContainer(dpWidth, dpHeight, 10.0, 20.0,
                            Colors.black, PaintingStyle.stroke),
                      ),
                      // CHANGE DP BUTTON
                      Positioned(
                        bottom: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0)),
                            color: Colors.black,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              getImage();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.0),
          // USER NAME
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentUser.email.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: DesignElements.tirtiaryFont,
                ),
              ),
            ],
          ),
          // LOG OUT BUTTON
          Container(
            height: 200.0,
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  CustomPaint(
                    painter: DentContainer(
                      94.0,
                      44.0,
                      10.0,
                      10.0,
                      Colors.black,
                      PaintingStyle.fill,
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/");
                      },
                      child: Text(
                        "LOGOUT",
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontFamily: DesignElements.tirtiaryFont,
                        ),
                      ),
                    ),
                  ),
                  CustomPaint(
                    painter: DentContainer(
                      94.0,
                      44.0,
                      10.0,
                      10.0,
                      Colors.black,
                      PaintingStyle.stroke,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePicPainter extends CustomPainter {
  final double dpWidth;
  final double dpHeight;
  ProfilePicPainter(this.dpWidth, this.dpHeight);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = DesignElements.black;
    paint.style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(30, 0);
    path.lineTo(dpWidth, 0);
    path.lineTo(dpWidth, dpHeight - 30);
    path.lineTo(dpHeight - 30, dpHeight);
    path.lineTo(0, dpHeight);
    path.lineTo(0, 30);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ProfilePicClipper extends CustomClipper<Path> {
  final double dpWidth;
  final double dpHeight;
  ProfilePicClipper(this.dpWidth, this.dpHeight);
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = DesignElements.black;
    paint.style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(30, 0);
    path.lineTo(dpWidth, 0);
    path.lineTo(dpWidth, dpHeight - 30);
    path.lineTo(dpHeight - 30, dpHeight);
    path.lineTo(0, dpHeight);
    path.lineTo(0, 30);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
