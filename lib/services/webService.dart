import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  final SharedPreferences prefs;
  SharedPrefService({required this.prefs});

  Future<int> getOrSetValueInt(name, value) async {
    int? ins = this.prefs.getInt(name);

    if (ins == null) {
      // If not found, set a default value
      await this.prefs.setInt(name, value);
      return value;
    }
    return ins;
  }
}

class WebService {
  Future getHomeFeed() async {
    final prefs = await SharedPreferences.getInstance();
    SharedPrefService pref = SharedPrefService(prefs: prefs);

    int pnum = await pref.getOrSetValueInt("pnum", 1);

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
