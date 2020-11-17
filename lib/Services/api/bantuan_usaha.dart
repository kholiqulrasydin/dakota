import 'dart:convert';

import 'package:dakota/Dashboard/pie_chart.dart';
import 'package:dakota/Services/api/dakota.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/Services/providers/dakota.dart';
import 'package:dakota/model/BantuanUsahaModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BantuanUsahaApi {
  static Future<void> createData(
      BuildContext context,
      BantuanUsaha bantuanUsaha,
      DakotaProvider dakotaProvider,
      int idDakota,
      String nama,
      String detail,
      String status,
      int jumlah,
      String dateTime,
      String keterangan) async {
    final prefs = await SharedPreferences.getInstance();

    bool success = false;

    await http.post('http://apidinper.reboeng.com/api/bantuanusaha',
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
        body: {
          'id_dakota': idDakota.toString(),
          'nama': nama,
          'detail': detail,
          'status': status,
          'jumlah': jumlah.toString(),
          'tahun': dateTime.toString(),
          'keterangan': keterangan
        }).then((response) {
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        print('oke! status ${response.statusCode}');
        success = true;
      } else {
        print('Failed To Create Bantuan Usaha');
        success = false;
      }
    });

    if (success) {
      return await DakotaApi.getPersonalGroup(
          context, dakotaProvider, idDakota, bantuanUsaha);
    } else {
      return 0;
    }
  }

  static Future<void> getCountDatabyUser(BantuanUsaha bantuanUsaha) async {
    final prefs = await SharedPreferences.getInstance();
    http.Response response = await http.get(
        'http://apidinper.reboeng.com/api/bantuanusaha/countdata/byUser',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.statusCode.toString());
      Map<String, dynamic> jsondata = jsonDecode(response.body);
      final dataa = jsondata['count'];

      List<Category> keyCategory = [
        Category('${dataa['alsintan']} Alsintan',
            amount: dataa['alsintan'] + .0),
        Category('${dataa['sarpras']} SARPRAS', amount: dataa['sarpras'] + .0),
        Category('${dataa['bibit']} Bibit/Benih', amount: dataa['bibit'] + .0),
        Category('${dataa['ternak']} Ternak', amount: dataa['ternak'] + .0),
        Category('${dataa['perikanan']} Perikanan',
            amount: dataa['perikanan'] + .0),
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

  static Future<void> getCountData(BantuanUsaha bantuanUsaha) async {
    final prefs = await SharedPreferences.getInstance();
    http.Response response = await http.get(
        'http://apidinper.reboeng.com/api/bantuanusaha/countdata',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.statusCode.toString());
      Map<String, dynamic> jsondata = jsonDecode(response.body);
      final dataa = jsondata['count'];

      List<Category> keyCategory = [
        Category('${dataa['alsintan']} Alsintan',
            amount: dataa['alsintan'] + .0),
        Category('${dataa['sarpras']} SARPRAS', amount: dataa['sarpras'] + .0),
        Category('${dataa['bibit']} Bibit/Benih', amount: dataa['bibit'] + .0),
        Category('${dataa['ternak']} Ternak', amount: dataa['ternak'] + .0),
        Category('${dataa['perikanan']} Perikanan',
            amount: dataa['perikanan'] + .0),
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

  static Future<void> deleteBantuan(BuildContext context, DakotaProvider dakotaProvider, BantuanUsaha bantuanUsaha, int id) async {
    final prefs = await SharedPreferences.getInstance();
    http.Response response = await http.delete(
        'http://apidinper.reboeng.com/api/bantuanusaha/$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        });

    if(response.statusCode == 200){
      return await DakotaApi.getPersonalGroup(context, dakotaProvider, id, bantuanUsaha);
    }else{
      return print('Gagal Menghapus Data bantuan');
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
