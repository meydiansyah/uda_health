import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:uda_health/model/food.dart';

class FoodProvider with ChangeNotifier {
  String _name;
  String get name => _name;

  void setName(String val) {
    _name = val;
  }

  createData() async {
    String date = DateFormat("d - M - yyyy").format(DateTime.now());

    var resp = await http.post("http://192.168.100.3/uda_healthy/create_food.php",
        body: {'name': _name, 'date': date});

    print(resp.body);
    notifyListeners();
  }

  Future<List<Food>> getData() async {
    var resp = await http.post("http://192.168.100.3/uda_healthy/food.php");

    if (resp.statusCode == 200) {
      List list = json.decode(resp.body);
      return list.map((e) => Food.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data Food');
    }
  }
}
