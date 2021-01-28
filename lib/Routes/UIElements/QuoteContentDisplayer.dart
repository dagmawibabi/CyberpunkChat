import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

class QuoteContent extends StatelessWidget {
  const QuoteContent({
    Key key,
    @required this.quoteSource,
    @required this.quoteTag,
    @required this.quoteContent,
    @required this.quoteAuthor,
  }) : super(key: key);

  final String quoteSource;
  final String quoteTag;
  final String quoteContent;
  final String quoteAuthor;

  @override
  Widget build(BuildContext context) {
    double width = 394.0;
    double height = 166.0;
    return Container(
      margin: EdgeInsets.only(left: 8.0, right: 6.0, top: 6.0, bottom: 0.0),
      child: Stack(
        children: [
          CustomPaint(
            painter: DentContainer(width, height, 10.0, 10.0, Colors.grey[300],
                PaintingStyle.fill),
          ),
          CustomPaint(
            painter: DentContainer(
                width, height, 10.0, 10.0, Colors.black, PaintingStyle.stroke),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      quoteSource.toString().toUpperCase(),
                      style: TextStyle(
                        fontFamily: DesignElements.tirtiaryFont,
                      ),
                    ),
                    Text(
                      quoteTag.toString().toUpperCase(),
                      style: TextStyle(
                        fontFamily: DesignElements.tirtiaryFont,
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.black, thickness: 1.0),
                Container(
                  height: 70.0,
                  padding: EdgeInsets.only(
                      top: 0.0, bottom: 8.0, left: 8.0, right: 8.0),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  child: ListView(
                    children: [
                      Text(
                        "\"" + quoteContent.toString().toUpperCase() + "\"",
                        style: TextStyle(
                          fontFamily: DesignElements.tirtiaryFont,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black, thickness: 1.0),
                Text(
                  "- " + quoteAuthor.toString().toUpperCase() + " -",
                  style: TextStyle(
                    fontFamily: DesignElements.tirtiaryFont,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
