import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WebService {
  Future<List> getHomeFeed() async {
    final prefs = await SharedPreferences.getInstance();

    int? pnum = prefs.getInt("pnum");
    if (pnum == null) {
      await prefs.setInt("pnum", 1);
      pnum = 1;
    }

    final uri = Uri.parse("http://localhost:8000/a/home/?pnum=${pnum}");
    http.Response response = await http.get(uri);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      return jsonData["data"];
    } else {
      return [];
    }
  }
}
