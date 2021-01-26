import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/HumorContent/HumorServices.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/NewsContent/NewsCard.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/NewsContent/NewsServices.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/NewsContent/NewsTab.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/QuoteContent/QuoteServices.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/Content/QuoteContent/QuotesTab.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';

void main() {
  runApp(FeedPage());
}

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> with TickerProviderStateMixin {
  bool isNewsTabLoading = true;
  bool isQuotesTabLoading = true;
  bool isHumorTabLoading = true;
  List newsArticlesList = [];
  List quotesList = [];
  List humorList = [];
  // NEWS
  void getNews() async {
    NewsServices ns = NewsServices();
    await ns.getHeadLines();
    newsArticlesList = ns.articlesList;
    isNewsTabLoading = false;
    setState(() {});
  }

  Future<void> getNewsRefresh() async {
    isNewsTabLoading = true;
    newsArticlesList = [];
    setState(() {});
    getNews();
  }

  // QUOTES
  void getQuotes() async {
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
  }

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

  void getContent() {
    getNews();
    getQuotes();
    getHumor();
  }

  @override
  void dispose() {
    super.dispose();
    isNewsTabLoading = true;
    isQuotesTabLoading = true;
    isHumorTabLoading = true;
    newsArticlesList = [];
    quotesList = [];
  }

  @override
  void initState() {
    super.initState();
    getContent();
  }

  @override
  Widget build(BuildContext context) {
    double newsCardWidth = 392.0;
    double newsCardHeight = 492.0;
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
          Container(child: Center(child: Text("1"))),
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
                  quotesList: quotesList, getQuotesRefresh: getQuotesRefresh)
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
          // HUMOR TAB
          isHumorTabLoading == false
              ? RefreshIndicator(
                  onRefresh: () => getHumorRefresh(),
                  child: ListView.builder(
                    itemCount: humorList[0][1].length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 10.0,
                                bottom: 0.0),
                            child: Stack(
                              children: [
                                CustomPaint(
                                  painter: DentContainer(
                                      newsCardWidth,
                                      newsCardHeight,
                                      20.0,
                                      14.0,
                                      Colors.grey[300],
                                      PaintingStyle.fill),
                                ),
                                CustomPaint(
                                  painter: DentContainer(
                                      newsCardWidth,
                                      newsCardHeight,
                                      20.0,
                                      14.0,
                                      Colors.black,
                                      PaintingStyle.stroke),
                                ),
                                Container(
                                  width: newsCardWidth,
                                  height: newsCardHeight,
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      // MEME
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              "MEME API",
                                              style: TextStyle(
                                                fontFamily:
                                                    DesignElements.tirtiaryFont,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "MEMES",
                                            style: TextStyle(
                                              fontFamily:
                                                  DesignElements.tirtiaryFont,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                          color: Colors.black, thickness: 2.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "@" +
                                                humorList[0][1][index]["author"]
                                                    .toString()
                                                    .toUpperCase(),
                                            style: TextStyle(
                                              fontFamily:
                                                  DesignElements.tirtiaryFont,
                                            ),
                                          ),
                                          Text(
                                            humorList[0][1][index]["ups"]
                                                    .toString()
                                                    .toUpperCase() +
                                                " ^",
                                            style: TextStyle(
                                              fontFamily:
                                                  DesignElements.tirtiaryFont,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                          color: Colors.black, thickness: 1.0),
                                      // Image
                                      "MEMES" != null
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  "memeViewer",
                                                  arguments: {
                                                    "meme": humorList[0][1]
                                                        [index]["url"],
                                                  },
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  Image.network(
                                                    humorList[0][1][index]
                                                        ["url"],
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
                                              ),
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
                                      //SizedBox(height: 10.0),
                                      Divider(
                                          color: Colors.black, thickness: 1.0),
                                      Container(
                                        height: 20.0,
                                        child: ListView(
                                          children: [
                                            Text(
                                              "\"" +
                                                  humorList[0][1][index]
                                                          ["title"]
                                                      .toString()
                                                      .toUpperCase() +
                                                  "\"",
                                              style: TextStyle(
                                                fontFamily:
                                                    DesignElements.tirtiaryFont,
                                              ),
                                              //maxLines: 1,
                                              //overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                          color: Colors.black, thickness: 1.0),
                                      // CONTENT
                                      Stack(
                                        children: [
                                          CustomPaint(
                                            painter: DentContainer(
                                                370.0,
                                                36.0,
                                                10.0,
                                                10.0,
                                                Colors.grey[200],
                                                PaintingStyle.fill),
                                          ),
                                          CustomPaint(
                                            painter: DentContainer(
                                                370.0,
                                                36.0,
                                                10.0,
                                                10.0,
                                                Colors.black,
                                                PaintingStyle.stroke),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "NSFW",
                                                  style: TextStyle(
                                                    fontFamily: DesignElements
                                                        .tirtiaryFont,
                                                  ),
                                                ),
                                                Text(
                                                  humorList[0][1][index]["nsfw"]
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontFamily: DesignElements
                                                        .tirtiaryFont,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4.0),
                                      Stack(
                                        children: [
                                          CustomPaint(
                                            painter: DentContainer(
                                                370.0,
                                                36.0,
                                                10.0,
                                                10.0,
                                                Colors.grey[200],
                                                PaintingStyle.fill),
                                          ),
                                          CustomPaint(
                                            painter: DentContainer(
                                                370.0,
                                                36.0,
                                                10.0,
                                                10.0,
                                                Colors.black,
                                                PaintingStyle.stroke),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "SPOILER",
                                                  style: TextStyle(
                                                    fontFamily: DesignElements
                                                        .tirtiaryFont,
                                                  ),
                                                ),
                                                Text(
                                                  humorList[0][1][index]
                                                          ["spoiler"]
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontFamily: DesignElements
                                                        .tirtiaryFont,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          index == humorList[0][1].length - 1
                              ? Column(
                                  children: [
                                    SizedBox(height: 100.0),
                                    IconButton(
                                      icon: Icon(Icons.arrow_downward),
                                      onPressed: () {
                                        getHumorRefresh();
                                      },
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      );
                    },
                  ),
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
          Container(child: Center(child: Text("4"))),
          Container(child: Center(child: Text("4"))),
          Container(child: Center(child: Text("4"))),
        ],
      ),
    );
  }
}
