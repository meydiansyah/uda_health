

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:uda_health/model/news.dart';

import 'covid.dart';

class GetApi with ChangeNotifier{
  String _date;
  String _confirmed;
  String _recovered;
  String _death;
  String _active;

  String get date => _date;
  String get confirmed => _confirmed;
  String get recovered => _recovered;
  String get death => _death;
  String get active => _active;

  GetApi() {
    getCovid();
    getNews();
  }

  Future<News> getNews() async {
    try {
      final response = await http.get(
          "http://newsapi.org/v2/top-headlines?country=id&category=health&apiKey=97fb428247ec44da905fefd97429ed2a");
      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        News news = News.fromJson(json);
        return news;
      } else {
        print("Failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }


  Future<List<Covid>> getCovid() async {
    DateTime today = new DateTime.now();
    try {
      final response = await http.get(
          "https://api.covid19api.com/country/indonesia?from=2020-11-20T00:00:00Z&to=$today");
      if (response.statusCode == 200) {
        List resp = json.decode(response.body);

        _confirmed = resp.last['Confirmed'].toString();
        _active = resp.last['Active'].toString();
        _death = resp.last['Deaths'].toString();
        _recovered = resp.last['Recovered'].toString();
        _date = resp.last['Date'].toString().substring(0, 10);
        notifyListeners();
        return resp.map((cov) => Covid.fromJson(cov)).toList();
      } else {
        print("Failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

}