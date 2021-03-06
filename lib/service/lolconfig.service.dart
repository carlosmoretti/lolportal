import 'dart:io';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LolConfigService {
  Future<void> setLolConfig() async {
    var res = await http.get("https://ddragon.leagueoflegends.com/api/versions.json");
    
    if(res.statusCode == 200) {
      List item = json.decode(res.body);
      var _sharedPrefs = await SharedPreferences.getInstance();
      print(item.first);
      await _sharedPrefs.setString("lolVersion", item.first);
    }
  }

  Future<String> getLolConfig() async {
    var _sharedPrefs = await SharedPreferences.getInstance();
    String res = await _sharedPrefs.get("lolVersion");
    return res;
  }
}