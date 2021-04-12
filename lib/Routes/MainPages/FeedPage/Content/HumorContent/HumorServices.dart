import 'dart:convert';
import 'package:http/http.dart';
import 'dart:math';

class HumorServices {
  List humorList = [];
  Future<void> getHumer() async {
    // GET MEMES FROM SUBREDDITS
    /* 
      YOU CAN USE THESE KEYWORD TO FILTER THE POSTS
      KEYWORDS = [TOP, RISING, HOT, BEST, NEW] 
      FORMAT = https://www.reddit.com/r/SUBREDDIT/KEYWORD.json
    */
    List subRedditsList = [
      "jokes",
      "dadJokes",
      "dirtyJokes",
      "cleanJokes",
      "Demotivational",
      "funnySigns",
      "me_irl",
      "wellThatSucks",
      "youDontSurf",
      "ATBGE",
      "ShittyLifeProTips",
      "misleadingThumbnails",
      "shittyAskScience",
      "technicallyTheTruth",
      "bertsTrips",
      "4Chan",
      "DiWHY",
      "thereWasAnAttempt",
      "starterPacks",
      "facePalm",
      "photoshopBattles",
      "blunderyears",
      "trippinthroughtime",
      "dankmemes",
      "memes",
      "funny",
      "teenagers",
      "adviceAnimals",
      "memeEconomy",
      "comedyCemetery",
      "historyMemes",
      "bikiniBottomTwitter",
      "comedyNecromancy",
      "dontDeadOpenInside",
      "gameOfThronesMemes",
      "hmmm",
      "holUp",
    ];

    // Grab N-amount of trending memes from the subreddits
    for (var i = 0; i < subRedditsList.length; i++) {
      Response responseSubReddit = await get(
          Uri.parse("https://www.reddit.com/r/" + subRedditsList[i] + ".json"));
      dynamic responseSubRedditJSON = jsonDecode(responseSubReddit.body);

      for (var j = 0;
          j < 2 /*responseSubRedditJSON["data"]["children"].length*/;
          j++) {
        // GRAPHICAL JOKES
        if (responseSubRedditJSON["data"]["children"][j]["data"]
                    ["thumbnail_width"] !=
                null &&
            responseSubRedditJSON["data"]["children"][j]["data"]["is_video"] ==
                false) {
          humorList.add(
            [
              subRedditsList[i],
              responseSubRedditJSON["data"]["children"][j]["data"],
              true,
            ],
          );
        }
        // TEXT ONLY JOKES
        else {
          humorList.add(
            [
              subRedditsList[i],
              responseSubRedditJSON["data"]["children"][j]["data"],
              false,
            ],
          );
        }
      }
    }

    // Det Dad Jokes
    // SHUFFLE DATA
    print("--------------------------");
    print(humorList.length);
    print("--------------------------");
    humorList.shuffle();
  }
}
