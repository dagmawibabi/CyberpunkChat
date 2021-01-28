import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key key,
    @required this.newsImage,
    @required this.newsHeadline,
    @required this.newsDescription,
    @required this.newsCategory,
    @required this.newsSource,
    @required this.newsDate,
  }) : super(key: key);

  final String newsImage;
  final String newsHeadline;
  final String newsDescription;
  final String newsCategory;
  final String newsSource;
  final String newsDate;

  @override
  Widget build(BuildContext context) {
    double newsCardWidth = 392.0;
    double newsCardHeight = 500.0;

    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 0.0),
      child: Stack(
        children: [
          CustomPaint(
            painter: DentContainer(newsCardWidth, newsCardHeight, 20.0, 14.0,
                Colors.grey[300], PaintingStyle.fill),
          ),
          CustomPaint(
            painter: DentContainer(newsCardWidth, newsCardHeight, 20.0, 14.0,
                Colors.black, PaintingStyle.stroke),
          ),
          Container(
            width: newsCardWidth,
            height: newsCardHeight,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                // NEWS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "NEWS",
                        style: TextStyle(
                          fontFamily: DesignElements.tirtiaryFont,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("aha");
                      },
                      child: Text(
                        newsCategory.toUpperCase(),
                        style: TextStyle(
                          fontFamily: DesignElements.tirtiaryFont,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.black, thickness: 1.0),
                // Image
                newsImage != null
                    ? Stack(
                        children: [
                          Image.network(
                            newsImage,
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
                      )
                    : Stack(
                        children: [
                          CustomPaint(
                            painter: DentContainer(
                              370.0,
                              260.0,
                              0.0,
                              0.0,
                              Colors.white,
                              PaintingStyle.fill,
                            ),
                          ),
                          Image.asset(
                            "assets/images/newsPlaceholder2.jpg",
                            width: 400,
                            height: 260,
                            fit: BoxFit.contain,
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
                Divider(color: Colors.black, thickness: 1.0),
                // Headline
                Stack(
                  children: [
                    CustomPaint(
                      painter: DentContainer(366.0, 36.0, 10.0, 10.0,
                          Colors.grey[200], PaintingStyle.fill),
                    ),
                    CustomPaint(
                      painter: DentContainer(366.0, 36.0, 10.0, 10.0,
                          Colors.black, PaintingStyle.stroke),
                    ),
                    Container(
                      height: 36.0,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              newsHeadline != null
                                  ? newsHeadline.toUpperCase()
                                  : "",
                              //overflow: TextOverflow.ellipsis,
                              //maxLines: 1,
                              style: TextStyle(
                                fontFamily: DesignElements.tirtiaryFont,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.0),
                // Description
                Stack(
                  children: [
                    CustomPaint(
                      painter: DentContainer(366.0, 84.0, 10.0, 10.0,
                          Colors.grey[300], PaintingStyle.fill),
                    ),
                    CustomPaint(
                      painter: DentContainer(366.0, 84.0, 10.0, 10.0,
                          Colors.black, PaintingStyle.stroke),
                    ),
                    Container(
                      height: 84.0,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              newsDescription != null
                                  ? newsDescription.toUpperCase() + "\n\n\n"
                                  : "The description of this new article is currently unavailable. We will update as soon as it's available! Thank you!"
                                      .toUpperCase(),
                              //overflow: TextOverflow.ellipsis,
                              //maxLines: 3,
                              style: TextStyle(
                                fontFamily: DesignElements.secondaryFont,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.black, thickness: 1.0),
                // Source and Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        newsSource.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: DesignElements.tirtiaryFont,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        newsDate.substring(11, 16) +
                            " | " +
                            newsDate.substring(0, 10),
                        style: TextStyle(
                          fontFamily: DesignElements.tirtiaryFont,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
