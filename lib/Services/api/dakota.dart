import 'dart:convert';

import 'package:dakota/Services/api/bantuan_usaha.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/Services/providers/dakota.dart';
import 'package:dakota/dakota_view.dart';
import 'package:dakota/dakota_viewAll.dart';
import 'package:dakota/model/DakotaModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class DakotaApi{

  static Future<void> createDakota(
      BuildContext context,
      AuthProvider authProvider,
      String namaKelompok,
      String nomorRegister,
      String alamat,
      String kecamatan,
      String kelurahan,
      String geoLatitude,
      String geoLongtitude,
      String namaKetua,
      int jumlahAnggota,
      String jenisLahan,
      int luasLahan,
      String bidangUsaha,
      String subBidangUsaha) async {
    final prefs = await SharedPreferences.getInstance();
    await http.post(
      'http://apidinper.reboeng.com/api/dakota',
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
      body: {
        'nama_kelompok': namaKelompok,
        'nomor_register': nomorRegister,
        'alamat': alamat,
        'kecamatan': kecamatan,
        'kelurahan': kelurahan,
        'geo_latitude': geoLatitude,
        'geo_longtitude': geoLongtitude,
        'nama_ketua': namaKetua,
        'jumlah_anggota': jumlahAnggota.toString(),
        'jenis_lahan': jenisLahan,
        'luas_lahan': luasLahan.toString(),
        'bidang_usaha': bidangUsaha,
        'sub_bidang_usaha': subBidangUsaha,
      }).then((response) async {
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        print('oke! status ${response.statusCode}');
        return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>DarkotaViewAll()));
      } else {
        print('Failed To Create Dakota');
      }
    });


  }

  static Future<void> updateDakota(
      BuildContext context,
      AuthProvider authProvider,
      BantuanUsaha bantuanUsaha,
      DakotaProvider dakotaProvider,
      String namaKelompok,
      String nomorRegister,
      String alamat,
      String kecamatan,
      String kelurahan,
      String geoLatitude,
      String geoLongtitude,
      String namaKetua,
      int jumlahAnggota,
      String jenisLahan,
      int luasLahan,
      String bidangUsaha,
      String subBidangUsaha,
      int id) async {
    await http.put(
        'http://apidinper.reboeng.com/api/dakota/$id',
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authProvider.currentToken}'
        },
        body: {
          'nama_kelompok': namaKelompok,
          'nomor_register': nomorRegister,
          'alamat': alamat,
          'kecamatan': kecamatan,
          'kelurahan': kelurahan,
          'geo_latitude': geoLatitude,
          'geo_longtitude': geoLongtitude,
          'nama_ketua': namaKetua,
          'jumlah_anggota': jumlahAnggota.toString(),
          'jenis_lahan': jenisLahan,
          'luas_lahan': luasLahan.toString(),
          'bidang_usaha': bidangUsaha,
          'sub_bidang_usaha': subBidangUsaha,
        }).then((response) {
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        print('oke! status ${response.statusCode}, Dakota Successfully Updated');
        dakotaProvider.dakotaListOnce = [];
        getPersonalGroup(context, dakotaProvider, id, bantuanUsaha);
      } else {
        print('Failed To Update Dakota');
      }
    });


  }

//delete data
  static Future<void> deleteDakota(BuildContext context, GlobalKey<ScaffoldState> viewKey, int id) async {
    final prefs = await SharedPreferences.getInstance();
    await http.delete(
        'http://apidinper.reboeng.com/api/dakota/$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        }).then((response) {
      if (response.statusCode == 200) {
        DakotaModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to delete Dakota.');
      }
      return print(response.statusCode.toString());
    });
  }
  static Future<void> fetchDakota(AuthProvider authProvider, DakotaProvider dakotaProvider, String category) async {

    if(category == "all"){
      await http.get(
          'http://apidinper.reboeng.com/api/dakota',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${authProvider.currentToken}'
          }).then((response) {
        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.
          print(response.statusCode.toString());
          String content = response.body;
          List dakota = jsonDecode(content);
          return dakotaProvider.dakotaList = dakota.map((e) => DakotaModel.fromJson(e)).toList();
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          print(response.statusCode.toString());
          throw Exception('Failed to load Dakota');
        }
      });
    }else{
      await http.get(
          'http://apidinper.reboeng.com/api/search_bidang/$category',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${authProvider.currentToken}'
          }).then((response) {
        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.
          print(response.statusCode.toString());
          String content = response.body;
          List dakota = jsonDecode(content);
          return dakotaProvider.dakotaList = dakota.map((e) => DakotaModel.fromJson(e)).toList();
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          print(response.statusCode.toString());
          throw Exception('Failed to load Dakota');
        }
      });
    }


  }

  static Future<void> getLast(DakotaProvider dakotaProvider) async {
    final prefs = await SharedPreferences.getInstance();
    await http.get(
        'http://apidinper.reboeng.com/api/dakota/limit',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        }).then((response) {
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        print(response.statusCode.toString());
        String content = response.body;
        List dakota = jsonDecode(content);
        dakotaProvider.dakotaListLatest = dakota.map((e) => DakotaModel.fromJson(e)).toList();
        print('success mendapatkan data kelompok tani terbaru');
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print('gagal mendapatkan data kelompok tani terbaru');
        print(response.statusCode.toString());
      }
    });

  }

  static Future<void> getPersonalGroup(BuildContext context, DakotaProvider dakotaProvider,int id, BantuanUsaha bantuanUsaha) async {

    final prefs = await SharedPreferences.getInstance();
    await http.get(
        'http://apidinper.reboeng.com/api/dakota/selectPersonalGroup/$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        }).then((response) async {
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        print(response.statusCode.toString());
        String content = response.body;
        List dakota = jsonDecode(content);
        dakotaProvider.dakotaListOnce = dakota.map((e) => DakotaModel.fromJson(e)).toList();
        final _dakotaa = dakotaProvider.dakotaListOnce.first;
        await BantuanUsahaApi.getBantuanUsahaPersonalGroup(bantuanUsaha, _dakotaa.id);

        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DakotaView(_dakotaa.id, dakotaProvider.dakotaListOnce, bantuanUsaha.bantuanUsahaList)));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print(response.statusCode.toString());
        throw Exception('Failed to load Dakota');
      }
    });
  }

  static Future<void> searchDakota(String search, DakotaProvider dakotaProvider) async {
    final prefs = await SharedPreferences.getInstance();
    http.Response response =
      await http.get(
          'http://apidinper.reboeng.com/api/search_like/$search',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${prefs.getString('token')}'
          });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.statusCode.toString());
      String content = response.body;
      List dakota = jsonDecode(content);
      return dakotaProvider.dakotaList = dakota.map((e) => DakotaModel.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode.toString());
      throw Exception('Failed to load Dakota');
    }


  }

}