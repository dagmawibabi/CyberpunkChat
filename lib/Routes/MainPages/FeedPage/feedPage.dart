import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/HumorContent/HumorServices.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/HumorContent/HumorTab.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/NewsContent/NewsServices.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/NewsContent/NewsTab.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/QuoteContent/QuoteServices.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/QuoteContent/QuotesTab.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/WholesomeContent/WholesomeServices.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/WholesomeContent/WholesomeTab.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';

void main() {
  runApp(FeedPage());
}

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
  final List newsArticlesListFP;
  final bool isNewsTabLoadingFP;
  final List quotesListFP;
  final bool isQuotesTabLoadingFP;
  final Function getQuotesRefreshFP;
  const FeedPage({
    Key key,
    this.newsArticlesListFP,
    this.isNewsTabLoadingFP,
    this.quotesListFP,
    this.isQuotesTabLoadingFP,
    this.getQuotesRefreshFP,
  }) : super(key: key);
}

class _FeedPageState extends State<FeedPage> with TickerProviderStateMixin {
  bool isNewsTabLoading = true;
  bool isQuotesTabLoading = true;
  bool isHumorTabLoading = true;
  bool isWholesomeTabLoading = true;
  List newsArticlesList = [];
  List quotesList = [];
  List humorList = [];
  List wholesomeList = [];
  // NEWS
  void getNews() {
    newsArticlesList = widget.newsArticlesListFP;
    isNewsTabLoading = widget.isNewsTabLoadingFP;
    setState(() {});
  }
  /*void getNews() async {
    NewsServices ns = NewsServices();
    await ns.getHeadLines();
    newsArticlesList = ns.articlesList;
    isNewsTabLoading = false;
    setState(() {});
  }*/

  Future<void> getNewsRefresh() async {
    isNewsTabLoading = true;
    newsArticlesList = [];
    setState(() {});
    getNews();
  }

  // QUOTES
  void getQuotes() {
    quotesList = widget.quotesListFP;
    isQuotesTabLoading = widget.isQuotesTabLoadingFP;
    setState(() {});
  }

  /*void getQuotes() async {
    QuoteServices qs = QuoteServices();
    await qs.getQuotables();
    quotesList = qs.quotesList;
    isQuotesTabLoading = false;
    setState(() {});
  }

  Future<void> getQuotesRefresh() async {
    isQuotesTabLoading = true;
    quotesList = [];
    setState(() {});
    getQuotes();
  }*/

  // HUMOR
  void getHumor() async {
    HumorServices hs = HumorServices();
    await hs.getHumer();
    humorList = hs.humorList;
    isHumorTabLoading = false;
    setState(() {});
  }

  Future<void> getHumorRefresh() async {
    isHumorTabLoading = true;
    humorList = [];
    setState(() {});
    getHumor();
  }

  // Wholesome
  void getWholesome() async {
    WholesomeServices hs = WholesomeServices();
    await hs.getWholesome();
    wholesomeList = hs.wholesomeList;
    isWholesomeTabLoading = false;
    setState(() {});
  }

  Future<void> getWholesomeRefresh() async {
    isWholesomeTabLoading = true;
    wholesomeList = [];
    setState(() {});
    getWholesome();
  }

  void getContent() {
    getNews();
    getQuotes();
    getHumor();
    getWholesome();
  }
/*
  @override
  void dispose() {
    super.dispose();
    isNewsTabLoading = true;
    isQuotesTabLoading = true;
    isHumorTabLoading = true;
    isWholesomeTabLoading = true;
    newsArticlesList = [];
    quotesList = [];
    humorList = [];
    wholesomeList = [];
  }*/

  @override
  void initState() {
    super.initState();
    getContent();
  }

  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    TabController tabBarController = TabController(length: 7, vsync: this);
    TabBar _tabBar = TabBar(
      controller: tabBarController,
      isScrollable: true,
      labelColor: Colors.white,
      labelStyle: TextStyle(fontFamily: DesignElements.tirtiaryFont),
      unselectedLabelStyle: TextStyle(fontFamily: DesignElements.secondaryFont),
      indicatorWeight: 2.0,
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: [
        Tab(
          text: "HOME",
        ),
        Tab(
          text: "NEWS",
        ),
        Tab(
          text: "QUOTES",
        ),
        Tab(
          text: "HUMOR",
        ),
        Tab(
          text: "WHOLESOME",
        ),
        Tab(
          text: "EDUCATION",
        ),
        Tab(
          text: "HEALTH",
        ),
      ],
    );
    return Scaffold(
      backgroundColor: DesignElements.scaffoldBG,
      appBar: AppBar(
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
        bottom: PreferredSize(
          preferredSize: _tabBar.preferredSize,
          child: Container(
            width: 500.0,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              //border: Border.all(color: Colors.white),
            ),
            child: _tabBar,
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
                    painter: DentContainer(46.0, 36.0, 10.0, 8.0, Colors.black,
                        PaintingStyle.stroke),
                  ),
                  Positioned(
                    child: IconButton(
                      icon: Icon(
                        Icons.person_outline, //account_circle_outlined,
                        size: 24.0,
                        color: Colors.black, //DesignElements.appBarIcons,
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
      ),
      body: TabBarView(
        controller: tabBarController,
        children: [
          Container(child: Center(child: SelectableText("1"))),
          // NEWS TAB
          isNewsTabLoading == false
              ? NewsTab(
                  getNewsRefresh: getNewsRefresh,
                  newsArticlesList: newsArticlesList)
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
          // QUOTES TAB
          isQuotesTabLoading == false
              ? QuotesTab(
                  quotesList: quotesList,
                  getQuotesRefresh: widget.getQuotesRefreshFP,
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
          // HUMOR TAB
          isHumorTabLoading == false
              ? HumorTab(
                  contentList: humorList,
                  getRefresh: getHumorRefresh,
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
          // WHOLESOME TAB
          isWholesomeTabLoading == false
              ? WholesomeTab(
                  contentList: wholesomeList,
                  getRefresh: getWholesomeRefresh,
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
          Container(child: Center(child: SelectableText("4"))),
          Container(child: Center(child: SelectableText("4"))),
        ],
      ),
    );
  }
}
