import 'dart:convert';

import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/model/BantuanUsahaModel.dart';
import 'package:http/http.dart' as http;

class BantuanUsahaApi{
  static Future<void> getCountData(AuthProvider authProvider, BantuanUsaha bantuanUsaha) async {
    http.Response response = await http.get('http://apidinper.reboeng.com/api/bantuanusaha/countdata', headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${authProvider.currentToken}'});

    print('${authProvider.currentToken} statusnyaa');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.statusCode.toString());
      Map<String, dynamic> jsondata = jsonDecode(response.body);
      return bantuanUsaha.jData = jsondata['count'];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode.toString());
      throw Exception('Failed to load Bantuan Usaha Count');
    }
  }

  static Future<void> getBantuanUsahaPersonalGroup(BantuanUsaha bantuanUsaha, AuthProvider authProvider, int id)async{
    http.Response response =
    await http.get(
        'http://apidinper.reboeng.com/api/bantuanusaha/search/$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${authProvider.currentToken}'
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.statusCode.toString());
      String content = response.body;
      List bu = jsonDecode(content);
      return bantuanUsaha.bantuanUsahaList = bu.map((e) => BantuanUsahaModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode.toString());
      throw Exception('Failed to load Bantuan Usaha');
    }
  }
}