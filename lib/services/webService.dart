import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WebService {
  Future<List> getFeed(String category) async {
    if (category == "All") {
      var feed = await getHomeFeed();
      return feed;
    }
    var feed = await getCategoryFeed(category);
    return feed;
  }

  Future<List> getCategoryFeed(String category) async {
    final uri =
        Uri.parse("http://localhost:8000/a/category/?category=$category");
    http.Response response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      return [];
    }
  }

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
      // TODO: Implement page incrementation here
      // await prefs.setInt("pnum", pnum + 1);
      return jsonData["data"];
    } else {
      return [];
    }
  }

  Future<List<String>> getSuggestions(String query) async {
    final url = Uri.parse(
        'https://en.wikipedia.org/w/api.php?action=opensearch&format=json&search=$query');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data[1]);
    }
    return [];
  }

  Future<Map> search(String query) async {
    final url = Uri.parse("http://localhost:8000/a/search/?search=${query}");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData;
    } else {
      return {};
    }
  }

  Future<Map> getDetailFeed(
      String src, String category, String? wikiDetail) async {
    final uri = Uri.parse(
        "http://localhost:8000/a/detail/?s=${src}&category=${category}&wd=${wikiDetail}");
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData;
    } else {
      return {};
    }
  }
}
