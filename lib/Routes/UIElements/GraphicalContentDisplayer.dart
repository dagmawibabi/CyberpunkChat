import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

class GraphicalContent extends StatelessWidget {
  const GraphicalContent({
    Key? key,
    required this.source,
    required this.contentTag,
    required this.author,
    required this.title,
    required this.graphics,
    required this.ups,
    required this.isFlagged,
    required this.isNSFW,
    required this.isSpoiler,
  }) : super(key: key);

  final int ups;
  final String source;
  final String contentTag;
  final String author;
  final String title;
  final bool isFlagged;
  final bool isNSFW;
  final bool isSpoiler;
  final String graphics;

  @override
  Widget build(BuildContext context) {
    double width = 392.0;
    double height = 408.0;
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 0.0),
      child: Stack(
        children: [
          CustomPaint(
            painter: DentContainer(width, height, 20.0, 14.0, Colors.grey[300]!,
                PaintingStyle.fill),
          ),
          CustomPaint(
            painter: DentContainer(
                width, height, 20.0, 14.0, Colors.black, PaintingStyle.stroke),
          ),
          Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                // SOURCE AND CONTENT TAG
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SelectableText(
                          source.toString().toUpperCase(),
                          style: TextStyle(
                            fontFamily: DesignElements.tirtiaryFont,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          isFlagged == false
                              ? SelectableText(
                                  contentTag.toString().toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: DesignElements.tirtiaryFont,
                                  ),
                                )
                              : Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      margin: EdgeInsets.only(right: 6.0),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 10.0),
                                      child: Row(
                                        children: [
                                          isNSFW == true
                                              ? SelectableText(
                                                  "NSFW",
                                                  style: TextStyle(
                                                    color: Colors.red[700],
                                                    fontFamily: DesignElements
                                                        .tirtiaryFont,
                                                  ),
                                                )
                                              : Container(),
                                          isSpoiler == true
                                              ? SelectableText(
                                                  "SPOILER",
                                                  style: TextStyle(
                                                    color: Colors.orange[900],
                                                    fontFamily: DesignElements
                                                        .tirtiaryFont,
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    SelectableText(
                                      "WHOLESOME",
                                      style: TextStyle(
                                        fontFamily: DesignElements.tirtiaryFont,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black, thickness: 2.0),
                //AUTHOR AND UPS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 20.0,
                        child: ListView(
                          children: [
                            SelectableText(
                              "@" + author.toString().toUpperCase(),
                              style: TextStyle(
                                fontFamily: DesignElements.tirtiaryFont,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 20.0,
                        child: ListView(
                          children: [
                            SelectableText(
                              ups.toString().toUpperCase() + " ^",
                              style: TextStyle(
                                fontFamily: DesignElements.tirtiaryFont,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.black, thickness: 1.0),
                // GRAPHICS
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      "graphicsViewer",
                      arguments: {
                        "graphics": graphics,
                        "assetOrNetwork": "netwrok",
                      },
                    );
                  },
                  child: Stack(
                    children: [
                      Image.network(
                        graphics,
                        width: 400,
                        height: 260,
                        fit: BoxFit.cover,
                      ),
                      CustomPaint(
                        painter: DentContainer(
                          370.0,
                          260.0,
                          0.0,
                          0.0,
                          Colors.black,
                          PaintingStyle.stroke,
                        ),
                      ),
                    ],
                  ),
                ),
                //SizedBox(height: 10.0),
                Divider(color: Colors.black, thickness: 1.0),
                // TITLE
                Container(
                  height: 20.0,
                  child: ListView(
                    children: [
                      SelectableText(
                        "\"" + title.toString().toUpperCase() + "\"",
                        style: TextStyle(
                          fontFamily: DesignElements.tirtiaryFont,
                        ),
                        //maxLines: 1,
                        //overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black, thickness: 1.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
