import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

class TextOnlyContent extends StatelessWidget {
  const TextOnlyContent({
    Key? key,
    required this.source,
    required this.contentTag,
    required this.author,
    required this.ups,
    required this.content,
    required this.title,
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
  final String content;

  @override
  Widget build(BuildContext context) {
    final double width = 394.0;
    final double height = 206.0;

    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 4.0),
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
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                // SOURCE AND CONTENT TAG
                Row(
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
                                contentTag,
                                style: TextStyle(
                                  fontFamily: DesignElements.tirtiaryFont,
                                ),
                              )
                            : Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
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
                                    contentTag,
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
                Divider(color: Colors.black, thickness: 1.0),
                // AUTHOR AND UPS
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectableText(
                        "@" + author.toString().toUpperCase(),
                        style: TextStyle(
                          fontFamily: DesignElements.tirtiaryFont,
                        ),
                      ),
                      SelectableText(
                        ups.toString().toUpperCase() + " ^",
                        style: TextStyle(
                          fontFamily: DesignElements.tirtiaryFont,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black, thickness: 1.0),
                // Content
                Container(
                  height: 90.0,
                  padding: EdgeInsets.only(
                      top: 0.0, bottom: 8.0, left: 8.0, right: 8.0),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  child: ListView(
                    children: [
                      SelectableText(
                        "\"" +
                            title.toString().toUpperCase() +
                            content.toString().toUpperCase() +
                            "\"",
                        style: TextStyle(
                          fontFamily: DesignElements.tirtiaryFont,
                        ),
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
