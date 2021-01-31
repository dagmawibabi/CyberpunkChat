import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';
import 'package:socialmedia/Routes/MainPages/MusicPage/MusicImageContainer.dart';

void main() {
  runApp(MusicPage());
}

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  List images = [
    "assets/images/1.jpg",
    "assets/images/4.jpg",
    "assets/images/2.jpg",
    "assets/images/11.png",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DesignElements.scaffoldBG,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: DesignElements.appBarBG,
        title: Text(
          "MUSIC PLAYER",
          style: TextStyle(
            color: DesignElements.appBarTitle,
            fontSize: DesignElements.appBarTitleFontSize,
            fontFamily: DesignElements.mainFont,
            letterSpacing: DesignElements.appBarTitleLetterSpacing,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      child: Stack(
                        children: [
                          // SONG DETAILS
                          Positioned(
                            left: 0.0,
                            right: 20.0,
                            child: Stack(
                              children: [
                                CustomPaint(
                                  painter: MusicImageContainer(
                                      size.width - 14,
                                      100,
                                      20,
                                      20,
                                      10,
                                      Colors.black,
                                      PaintingStyle.stroke),
                                ),
                                CustomPaint(
                                  painter: MusicImageContainer(
                                      size.width - 14,
                                      100,
                                      20,
                                      20,
                                      10,
                                      Colors.grey[400],
                                      PaintingStyle.fill),
                                ),
                              ],
                            ),
                          ),
                          // SONG IMAGE
                          ClipPath(
                            clipper: MusicImageClipper(100, 100, 20, 20, 10,
                                Colors.black, PaintingStyle.fill),
                            child: Stack(
                              children: [
                                CustomPaint(
                                  size: Size(100, 100),
                                  painter: MusicImageContainer(100, 100, 20, 20,
                                      10, Colors.black, PaintingStyle.fill),
                                ),
                                ClipPath(
                                  clipper: MusicImageClipper(100, 100, 20, 20,
                                      10, Colors.black, PaintingStyle.fill),
                                  child: Image.asset(images[index]),
                                ),
                                CustomPaint(
                                  size: Size(100, 100),
                                  painter: MusicImageContainer(
                                      100,
                                      100,
                                      20,
                                      20,
                                      10,
                                      Colors.yellowAccent,
                                      PaintingStyle.stroke),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                index == 9 ? SizedBox(height: 60.0) : SizedBox(height: 6.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
