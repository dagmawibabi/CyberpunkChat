import 'package:diamond_notched_fab/diamond_fab_notched_shape.dart';
import 'package:diamond_notched_fab/diamond_notched_fab.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/MainPages/ChatPage/ChatPage.dart';
import 'package:socialmedia/Routes/MainPages/CryptoPage/CryptoPage.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';
import 'package:socialmedia/Routes/MainPages/SearchPage/SearchPage.dart';
import 'package:socialmedia/Routes/MainPages/SettingsPage/SettingsPage.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/feedPage.dart';
import 'package:socialmedia/Routes/MainPages/MusicPage/MusicPage.dart';
import 'dart:math';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/NewsContent/NewsServices.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/QuoteContent/QuoteServices.dart';

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // TRIAL START
  bool isContentLoading = true;
  List newsArticlesList = [];
  bool isNewsTabLoading = true;
  void getNews() async {
    NewsServices ns = NewsServices();
    await ns.getHeadLines();
    newsArticlesList = ns.articlesList;
    isNewsTabLoading = false;
    setState(() {});
  }

  List quotesList = [];
  bool isQuotesTabLoading = true;
  void getQuotes() async {
    QuoteServices qs = QuoteServices();
    await qs.getQuotables();
    quotesList = qs.quotesList;
    isQuotesTabLoading = false;
    isContentLoading = false;
    setState(() {});
    print("been here");
  }

  Future<void> getQuotesRefresh() async {
    print("----------------------");
    print(isQuotesTabLoading);
    isQuotesTabLoading = true;
    quotesList = [];
    QuoteServices qs = QuoteServices();
    await qs.getQuotables();
    quotesList = qs.quotesList;
    isQuotesTabLoading = false;
    isContentLoading = false;
    setState(() {});
    print(isQuotesTabLoading);
    print("----------------------");
  }

  // TRIAL END

  List pages = [
    FeedPage(),
    SearchPage(),
    MusicPage(),
    CryptoPage(),
    SettingsPage(),
    ChatPage(),
  ];
  int curPage = 0;
  @override
  void initState() {
    super.initState();
    getNews();
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    DesignElements de = DesignElements();
    de.getDarkModeValue();
    de.changeTheme();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: DesignElements.scaffoldBG,
        body: curPage == 0
            ? isContentLoading == false
                ? FeedPage(
                    newsArticlesListFP: newsArticlesList,
                    isNewsTabLoadingFP: isNewsTabLoading,
                    quotesListFP: quotesList,
                    isQuotesTabLoadingFP: isQuotesTabLoading,
                    getQuotesRefreshFP: getQuotesRefresh,
                  )
                : Container(
                    child: Center(child: Text('LOADING')),
                  )
            : pages[curPage],
        bottomNavigationBar: BottomAppBar(
          color: DesignElements.bottomNavBarBG,
          /*shape: CircularNotchedRectangle(),*/
          shape: DiamondFabNotchedShape(),
          notchMargin: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10.0),
              IconButton(
                  icon: Icon(
                    Icons
                        .home_outlined, //grain_sharp, //filter_tilt_shift_outlined, //donut_large_sharp, //data_usage_rounded,
                    //change_history_outlined, //bubble_chart_outlined, //ballot_outlined,
                    color: DesignElements.bottomNavBarIcons,
                  ),
                  onPressed: () {
                    setState(() {
                      curPage = 0;
                    });
                  }),
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: DesignElements.bottomNavBarIcons,
                  ),
                  onPressed: () {
                    setState(() {
                      curPage = 1;
                    });
                  }),
              IconButton(
                icon: Icon(
                  Icons.multitrack_audio_outlined,
                  color: DesignElements.bottomNavBarIcons,
                ),
                onPressed: () {
                  setState(() {
                    curPage = 2;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.stacked_line_chart,
                  color: DesignElements.bottomNavBarIcons,
                ),
                onPressed: () {
                  setState(() {
                    curPage = 3;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.memory_rounded,
                  color: DesignElements.bottomNavBarIcons,
                ),
                onPressed: () {
                  setState(() {
                    curPage = 4;
                  });
                },
              ),
            ],
          ),
        ),
        floatingActionButton: DiamondNotchedFab(
          backgroundColor: DesignElements.fabBG,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: Icon(
              Icons.message_outlined,
              color: DesignElements.fabIcons,
            ),
          ),
          onPressed: () {
            //Navigator.pushNamed(context, "chatPage");
            curPage = 5;
            setState(() {});
          },
        ),
        /*FloatingActionButton(
          backgroundColor: DesignElements.fabBG,
          child: Icon(
            Icons.message_outlined,
            color: DesignElements.fabIcons,
          ),
          onPressed: () {},
        ),*/
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
