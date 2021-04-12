import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/GraphicalContentDisplayer.dart';
import 'package:socialmedia/Routes/UIElements/TextContentDisplayer.dart';

class WholesomeTab extends StatelessWidget {
  const WholesomeTab({
    Key? key,
    required this.contentList,
    required this.getRefresh,
  }) : super(key: key);

  final List contentList;
  final Function getRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getRefresh(),
      child: ListView.builder(
        itemCount: contentList.length,
        itemBuilder: (context, index) {
          bool isFlagged = (contentList[index][1]["over_18"] == true ||
                  contentList[index][1]["spoiler"] == true)
              ? true
              : false;
          bool isNSFW = contentList[index][1]["over_18"];
          bool isSpoiler = contentList[index][1]["spoiler"];
          return Column(
            children: [
              contentList[index][2] == false
                  ?
                  // TEXT CONTENT
                  TextOnlyContent(
                      source: contentList[index][0],
                      contentTag: "WHOLESOME",
                      author: contentList[index][1]["author"],
                      ups: contentList[index][1]["ups"],
                      content: contentList[index][1]["selftext"],
                      title: contentList[index][1]["title"],
                      isFlagged: isFlagged,
                      isNSFW: isNSFW,
                      isSpoiler: isSpoiler,
                    )
                  // GRAPHICAL CONTENT
                  : GraphicalContent(
                      source: contentList[index][0],
                      contentTag: "WHOLESOME",
                      author: contentList[index][1]["author"],
                      ups: contentList[index][1]["ups"],
                      graphics: contentList[index][1]["url"],
                      title: contentList[index][1]["title"],
                      isFlagged: isFlagged,
                      isNSFW: isNSFW,
                      isSpoiler: isSpoiler,
                    ),
              index == contentList.length - 1
                  ? Column(
                      children: [
                        SizedBox(height: 100.0),
                        IconButton(
                          icon: Icon(Icons.arrow_downward),
                          onPressed: () {
                            getRefresh();
                          },
                        ),
                      ],
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
