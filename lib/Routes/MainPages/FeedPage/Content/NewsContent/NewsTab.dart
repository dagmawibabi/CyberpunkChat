import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/NewsContent/NewsCard.dart';

class NewsTab extends StatelessWidget {
  const NewsTab({
    Key key,
    @required this.newsArticlesList,
    @required this.getNewsRefresh,
  }) : super(key: key);
  final Function getNewsRefresh;

  final List newsArticlesList;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getNewsRefresh(),
      child: ListView.builder(
        itemCount: newsArticlesList.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NewsCard(
                newsImage: newsArticlesList[index]["urlToImage"],
                newsHeadline: newsArticlesList[index]["title"],
                newsDescription: newsArticlesList[index]["description"],
                newsCategory: "Tech",
                newsSource: newsArticlesList[index]["source"]["name"],
                newsDate: newsArticlesList[index]["publishedAt"],
              ),
              index == newsArticlesList.length - 1
                  ? Column(
                      children: [
                        SizedBox(height: 100.0),
                        IconButton(
                          icon: Icon(Icons.arrow_downward),
                          onPressed: () {
                            getNewsRefresh();
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
