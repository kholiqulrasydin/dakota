import 'dart:convert';

import 'package:dakota/Dashboard/pie_chart.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/model/BantuanUsahaModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BantuanUsahaApi {
  static Future<void> getCountData(BantuanUsaha bantuanUsaha) async {
    final prefs = await SharedPreferences.getInstance();
    http.Response response = await http.get(
        'http://apidinper.reboeng.com/api/bantuanusaha/countdata',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        });

    print('${prefs.getString('token')} statusnyaa');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.statusCode.toString());
      Map<String, dynamic> jsondata = jsonDecode(response.body);
      final dataa = jsondata['count'];

      List<Category> keyCategory = [
        Category('${dataa['alsintan']} Alsintan', amount: dataa['alsintan'] + .0),
        Category('${dataa['sarpras']} SARPRAS', amount: dataa['sarpras'] + .0),
        Category('${dataa['bibit']} Bibit/Benih', amount: dataa['bibit'] + .0),
        Category('${dataa['ternak']} Ternak', amount: dataa['ternak'] + .0),
        Category('${dataa['perikanan']} Perikanan', amount: dataa['perikanan'] + .0),
        Category('${dataa['lainnya']} Lainnya', amount: dataa['lainnya'] + .0),
      ];

      return bantuanUsaha.jData = keyCategory;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode.toString());
      throw Exception('Failed to load Bantuan Usaha Count');
    }
  }

  static Future<void> getBantuanUsahaPersonalGroup(
      BantuanUsaha bantuanUsaha, int id) async {
    final prefs = await SharedPreferences.getInstance();
    http.Response response = await http.get(
        'http://apidinper.reboeng.com/api/bantuanusaha/search/$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.statusCode.toString());
      String content = response.body;
      List bu = jsonDecode(content);
      return bantuanUsaha.bantuanUsahaList =
          bu.map((e) => BantuanUsahaModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode.toString());
      throw Exception('Failed to load Bantuan Usaha');
    }
  }
}
