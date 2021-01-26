import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
      ),
      body: ListView(
        children: [
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
                        size: Size(dpWidth, dpHeight),
                        painter: ProfilePicPainter(dpWidth, dpHeight),
                      ),
                      // DP
                      ClipPath(
                        clipper: ProfilePicClipper(dpWidth, dpHeight),
                        child: Image.asset(
                          _image == null
                              ? "assets/images/2.jpg"
                              : _image.toString(),
                        ),
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
