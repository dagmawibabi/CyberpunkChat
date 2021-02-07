import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';

void main() {
  runApp(SearchPage());
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    TextEditingController _searchedText = TextEditingController();
    return Scaffold(
      backgroundColor: DesignElements.scaffoldBG,
      appBar: AppBar(
        backgroundColor: DesignElements.appBarBG,
        automaticallyImplyLeading: false,
        title: Container(
          //height: 50.0,
          child: Stack(
            children: [
              CustomPaint(
                painter: DentContainer(screenWidth - 36, 44.0, 16.0, 8.0,
                    Colors.white, PaintingStyle.fill),
              ),
              Container(
                padding: EdgeInsets.only(left: 4.0, right: 4.0),
                child: TextField(
                  controller: _searchedText,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: DesignElements.black,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.open_in_new,
                        color: DesignElements.black,
                      ),
                      onPressed: () {},
                    ),
                    labelText: "Scan Cyberpunk",
                    labelStyle: TextStyle(
                      color: DesignElements.black,
                    ),
                    hintText: "Scan",
                    hintStyle: TextStyle(
                      color: DesignElements.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
/*AppBar(
        backgroundColor: DesignElements.appBarBG,
        title: TextField(
          controller: _searchedText,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
      ),*/
    );
  }
}

class CyberBoxPainter extends CustomPainter {
  final double screenWidth;
  final double screenHeight;
  CyberBoxPainter(this.screenWidth, this.screenHeight);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = DesignElements.grey;
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(16, 2);
    path.lineTo(screenWidth - 34, 2);
    path.quadraticBezierTo(screenWidth - 24, 2, screenWidth - 24, 8);
    path.lineTo(screenWidth - 24, 20);
    path.quadraticBezierTo(screenWidth - 24, 22, screenWidth - 40, 36);
    path.lineTo(screenWidth - 40, 36);
    path.lineTo(6, 36);
    path.quadraticBezierTo(2, 36, 2, 30);
    path.lineTo(2, 16);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
