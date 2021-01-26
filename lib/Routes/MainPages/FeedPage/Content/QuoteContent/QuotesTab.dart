import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/QuoteContent/QuotesCard.dart';

class QuotesTab extends StatelessWidget {
  const QuotesTab({
    Key key,
    @required this.quotesList,
    @required this.getQuotesRefresh,
  }) : super(key: key);

  final List quotesList;
  final Function getQuotesRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getQuotesRefresh,
      child: ListView.builder(
        itemCount: quotesList.length,
        itemBuilder: (context, index) {
          Widget qc;
          if (quotesList[index][0] == "QUOTABLE") {
            qc = QuotesCard(
              quoteSource: "QUOTABLE",
              quoteTag: quotesList[index][1]["tags"][0],
              quoteContent: quotesList[index][1]["content"],
              quoteAuthor: quotesList[index][1]["author"],
            );
          } else if (quotesList[index][0] == "TYPE.FIT") {
            qc = QuotesCard(
              quoteSource: "TYPE.FIT",
              quoteTag: "QUOTES",
              quoteContent: quotesList[index][1]["text"],
              quoteAuthor: quotesList[index][1]["author"],
            );
          } else if (quotesList[index][0] == "ADVICE SLIP") {
            qc = QuotesCard(
              quoteSource: "ADVICE SLIP",
              quoteTag: "ADVICE",
              quoteContent: quotesList[index][1]["advice"],
              quoteAuthor: "ADVICE SLIP.COM",
            );
          } else if (quotesList[index][0] == "AFFIRMATIONS") {
            qc = QuotesCard(
              quoteSource: "AFFIRMATIONS",
              quoteTag: "AFFIRMATION",
              quoteContent: quotesList[index][1]["affirmation"],
              quoteAuthor: "AFFIRMATIONS.DEV",
            );
          }
          return Column(
            children: [
              qc,
              index == quotesList.length - 1
                  ? Column(
                      children: [
                        SizedBox(height: 50.0),
                        IconButton(
                          icon: Icon(Icons.arrow_downward),
                          onPressed: () {
                            getQuotesRefresh();
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
