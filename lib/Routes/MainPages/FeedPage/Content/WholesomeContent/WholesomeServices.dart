import 'dart:convert';
import 'package:http/http.dart';
import 'dart:math';

class WholesomeServices {
  List wholesomeList = [];
  Future<void> getWholesome() async {
    // GET MEMES FROM SUBREDDITS
    /* 
      YOU CAN USE THESE KEYWORD TO FILTER THE POSTS
      KEYWORDS = [TOP, RISING, HOT, BEST, NEW] 
      FORMAT = https://www.reddit.com/r/SUBREDDIT/KEYWORD.json
    */
    List subRedditsList = [
      "awww",
      "Awwducational",
      "wholesomeMemes",
      "thisMadeMeSmile",
      "eyeBleach",
      "humansBeingBros",
      "ActualHippies",
      "Rabbits",
      "CatSmiles",
      "wholesomegreentext",
      "MadeMeSmile",
      "guineapigs",
      "AnimalsBeingBros",
    ];

    // Grab N-amount of trending content from the subreddits
    for (var i = 0; i < subRedditsList.length; i++) {
      Response responseSubReddit =
          await get("https://www.reddit.com/r/" + subRedditsList[i] + ".json");
      dynamic responseSubRedditJSON = jsonDecode(responseSubReddit.body);

      for (var j = 0;
          j < 2 /*responseSubRedditJSON["data"]["children"].length*/;
          j++) {
        // GRAPHICAL CONTENT
        if (responseSubRedditJSON["data"]["children"][j]["data"]
                    ["thumbnail_width"] !=
                null &&
            responseSubRedditJSON["data"]["children"][j]["data"]["is_video"] ==
                false) {
          wholesomeList.add(
            [
              subRedditsList[i],
              responseSubRedditJSON["data"]["children"][j]["data"],
              true,
            ],
          );
        }
        // TEXT ONLY CONTENT
        else {
          wholesomeList.add(
            [
              subRedditsList[i],
              responseSubRedditJSON["data"]["children"][j]["data"],
              false,
            ],
          );
        }
      }
    }

    // SHUFFLE DATA
    wholesomeList.shuffle();
  }
}
