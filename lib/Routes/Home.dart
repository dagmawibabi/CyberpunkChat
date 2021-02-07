import 'package:diamond_notched_fab/diamond_fab_notched_shape.dart';
import 'package:diamond_notched_fab/diamond_notched_fab.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/MainPages/ChatPage/ChatPage.dart';
import 'package:socialmedia/Routes/MainPages/CryptoPage/CryptoPage.dart';
import 'package:socialmedia/Routes/MainPages/CryptoPage/CryptoServices.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
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
  }

  Future<void> getQuotesRefresh() async {
    isQuotesTabLoading = true;
    quotesList = [];
    QuoteServices qs = QuoteServices();
    await qs.getQuotables();
    quotesList = qs.quotesList;
    isQuotesTabLoading = false;
    isContentLoading = false;
    setState(() {});
  }

  /* GET CRYPTO
    List cryptosPriceData = []; 
  void getCryptoPrices() async {
    cryptosPriceData = [];
    CryptoServices cs = CryptoServices();
    await cs.getPrices();
    for (var i = 0; i < 100; i++) {
      cryptosPriceData.add(cs.allCryptoPriceDataList[i]);
    }
    isContentLoading = false;
    setState(() {});
  }*/

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
        appBar: isContentLoading && curPage == 0
            ? AppBar(
                shadowColor: Colors.white,
                backgroundColor: DesignElements.appBarBG,
                automaticallyImplyLeading: false,
                title: Text(
                  "Cyberpunk",
                  style: TextStyle(
                    color: DesignElements.appBarTitle,
                    fontSize: DesignElements.appBarTitleFontSize,
                    fontFamily: DesignElements.mainFont,
                    letterSpacing: DesignElements.appBarTitleLetterSpacing,
                  ),
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.only(top: 16.0, right: 8.0),
                    child: Container(
                      width: 46.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CustomPaint(
                            painter: DentContainer(46.0, 36.0, 10.0, 8.0,
                                Colors.grey[400], PaintingStyle.fill),
                          ),
                          CustomPaint(
                            painter: DentContainer(46.0, 36.0, 10.0, 8.0,
                                Colors.black, PaintingStyle.stroke),
                          ),
                          Positioned(
                            child: IconButton(
                              icon: Icon(
                                Icons.person_outline, //account_circle_outlined,
                                size: 24.0,
                                color:
                                    Colors.black, //DesignElements.appBarIcons,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, "profilePage");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : null,
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
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
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
