import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fiton/models/news.dart';

import '../constant.dart';

// ignore: camel_case_types
class API_Manager {
  Future<NewsModel> getNews(String url) async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (e) {
      print("news api");
      print(e);
      return newsModel;
    }

    return newsModel;
  }
}