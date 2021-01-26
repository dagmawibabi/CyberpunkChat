import 'package:diamond_notched_fab/diamond_fab_notched_shape.dart';
import 'package:diamond_notched_fab/diamond_notched_fab.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/MainPages/CryptoPage/CryptoPage.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';
import 'package:socialmedia/Routes/MainPages/SearchPage/SearchPage.dart';
import 'package:socialmedia/Routes/MainPages/SettingsPage/SettingsPage.dart';
import 'package:socialmedia/Routes/MainPages/FeedPage/feedPage.dart';
import 'package:socialmedia/Routes/MainPages/MusicPage/MusicPage.dart';
import 'dart:math';

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List pages = [
    FeedPage(),
    SearchPage(),
    MusicPage(),
    CryptoPage(),
    SettingsPage()
  ];
  int curPage = 0;

  @override
  void initState() {
    super.initState();
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
        body: pages[curPage],
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
          onPressed: () {},
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
