import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/QuoteContentDisplayer.dart';

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
            qc = QuoteContent(
              quoteSource: "QUOTABLE",
              quoteTag: quotesList[index][1]["tags"][0],
              quoteContent: quotesList[index][1]["content"],
              quoteAuthor: quotesList[index][1]["author"],
            );
          } else if (quotesList[index][0] == "TYPE.FIT") {
            qc = QuoteContent(
              quoteSource: "TYPE.FIT",
              quoteTag: "QUOTES",
              quoteContent: quotesList[index][1]["text"],
              quoteAuthor: quotesList[index][1]["author"],
            );
          } else if (quotesList[index][0] == "ADVICE SLIP") {
            qc = QuoteContent(
              quoteSource: "ADVICE SLIP",
              quoteTag: "ADVICE",
              quoteContent: quotesList[index][1]["advice"],
              quoteAuthor: "ADVICE SLIP.COM",
            );
          } else if (quotesList[index][0] == "AFFIRMATIONS") {
            qc = QuoteContent(
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
