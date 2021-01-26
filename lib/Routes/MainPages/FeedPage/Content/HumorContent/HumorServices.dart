import 'dart:convert';
import 'package:http/http.dart';
import 'dart:math';

class HumorServices {
  List humorList = [];
  Future<void> getHumer() async {
    // GET MULTIP RANDOM MEMES FROM MEME API
    Response responseMemes =
        await get("https://meme-api.herokuapp.com/gimme/25");
    dynamic responseMemesJSON = jsonDecode(responseMemes.body);
    humorList.add(["MEMES", responseMemesJSON["memes"]]);

    humorList.shuffle();
  }
}
