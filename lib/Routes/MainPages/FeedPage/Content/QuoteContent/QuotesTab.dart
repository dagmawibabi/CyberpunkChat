import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/QuoteContentDisplayer.dart';

class QuotesTab extends StatefulWidget {
  const QuotesTab({
    Key? key,
    required this.quotesList,
    required this.getQuotesRefresh,
  }) : super(key: key);

  final List quotesList;
  final Function getQuotesRefresh;

  @override
  _QuotesTabState createState() => _QuotesTabState();
}

class _QuotesTabState extends State<QuotesTab> {
  Future refreshSelf() async {
    await widget.getQuotesRefresh();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshSelf,
      child: ListView.builder(
        itemCount: widget.quotesList.length,
        itemBuilder: (context, index) {
          Widget? qc;
          if (widget.quotesList[index][0] == "QUOTABLE") {
            qc = QuoteContent(
              quoteSource: "QUOTABLE",
              quoteTag: widget.quotesList[index][1]["tags"][0],
              quoteContent: widget.quotesList[index][1]["content"],
              quoteAuthor: widget.quotesList[index][1]["author"],
            );
          } else if (widget.quotesList[index][0] == "TYPE.FIT") {
            qc = QuoteContent(
              quoteSource: "TYPE.FIT",
              quoteTag: "QUOTES",
              quoteContent: widget.quotesList[index][1]["text"],
              quoteAuthor: widget.quotesList[index][1]["author"],
            );
          } else if (widget.quotesList[index][0] == "ADVICE SLIP") {
            qc = QuoteContent(
              quoteSource: "ADVICE SLIP",
              quoteTag: "ADVICE",
              quoteContent: widget.quotesList[index][1]["advice"],
              quoteAuthor: "ADVICE SLIP.COM",
            );
          } else if (widget.quotesList[index][0] == "AFFIRMATIONS") {
            qc = QuoteContent(
              quoteSource: "AFFIRMATIONS",
              quoteTag: "AFFIRMATION",
              quoteContent: widget.quotesList[index][1]["affirmation"],
              quoteAuthor: "AFFIRMATIONS.DEV",
            );
          }
          return Column(
            children: [
              qc!,
              index == widget.quotesList.length - 1
                  ? Column(
                      children: [
                        SizedBox(height: 50.0),
                        IconButton(
                          icon: Icon(Icons.arrow_downward),
                          onPressed: () {
                            widget.getQuotesRefresh();
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
