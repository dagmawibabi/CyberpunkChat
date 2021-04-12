import 'dart:convert';

import 'package:http/http.dart';

class NewsServices {
  late List articlesList;
  dynamic responseJSON;
  Future<void> getHeadLines() async {
    // TOP HEADLINES
    Response response = await get(Uri.parse(
        "http://newsapi.org/v2/top-headlines?country=us&apiKey=158f7ed38d5e42aea76930d43ecca9c8"));
    responseJSON = jsonDecode(response.body);
    if (responseJSON["code"] == "rateLimited" ||
        responseJSON["code"] == "apiKeyExhausted") {
      Response response = await get(Uri.parse(
          "http://newsapi.org/v2/top-headlines?country=us&apiKey=349d44b960cc44c8b539926334aec104"));
      responseJSON = jsonDecode(response.body);
    }
    if (responseJSON["code"] == "rateLimited" ||
        responseJSON["code"] == "apiKeyExhausted") {
      Response response = await get(Uri.parse(
          "http://newsapi.org/v2/top-headlines?country=us&apiKey=e80bfe38d0ce4fbd8d36c45bb601ef08"));
      responseJSON = jsonDecode(response.body);
    }
    articlesList = responseJSON["articles"];
    // bbc-news
    // GENERAL
    // BUSINESS
    // ENTERTAINMENT
    // HEALTH
    // SCIENCE
    // SPORTS
    // TECHNOLOGY
  }
}
