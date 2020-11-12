import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class BantuanUsahaModel{
  int id;
  int idDakota;
  String nama;
  String detail;
  String status;
  int jumlah;
  String tahun;
  String keterangan;


  BantuanUsahaModel({this.id,this.idDakota,this.nama,this.detail,this.status,this.jumlah,this.tahun,this.keterangan});

  factory BantuanUsahaModel.fromJson(Map<String, dynamic> json) {
    return BantuanUsahaModel(
      id: json['id'],
      idDakota: json['id_dakota'],
      nama: json['nama'],
      detail: json['detail'],
      status: json['status'],
      jumlah: json['jumlah'],
      tahun: json['tahun'],
      keterangan: json['keterangan'],
    );
  }
  //create data
  Future<BantuanUsahaModel> createBantuanUsaha(int idDakota,String nama,String detail,String status
      ,int jumlah,String tahun,String keterangan) async {
    final http.Response response = await http.post(
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id_dakota': idDakota.toString(),
        'nama': nama,
        'detail': detail,
        'status': status,
        'jumlah': jumlah.toString(),
        'tahun': tahun,
        'keterangan': keterangan,

      }),
    );

    if (response.statusCode == 201) {
      return BantuanUsahaModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Bantuan Usaha.');
    }
  }
  //update data
  Future<BantuanUsahaModel> updateBantuan(int idDakota,String nama,String detail,String status
      ,int jumlah,DateTime tahun,String keterangan) async {
    final http.Response response = await http.put(
      'https://jsonplaceholder.typicode.com/albums/1',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id_dakota': idDakota.toString(),
        'nama': nama,
        'detail': detail,
        'status': status,
        'jumlah': jumlah.toString(),
        'tahun': tahun.toString(),
        'keterangan': keterangan,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return BantuanUsahaModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update Bantuan Usaha.');
    }
  }
  //delete data
  Future<BantuanUsahaModel> deleteBantuanUsaha(String id) async {
    final http.Response response = await http.delete(
      'https://jsonplaceholder.typicode.com/albums/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON. After deleting,
      // you'll get an empty JSON `{}` response.
      // Don't return `null`, otherwise `snapshot.hasData`
      // will always return false on `FutureBuilder`.
      return BantuanUsahaModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete Bantuan Usaha.');
    }
  }
  //fetch data
  Future<BantuanUsahaModel> fetchBantuanUsaha() async {
    final response =
    await http.get('https://jsonplaceholder.typicode.com/albums/1');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return BantuanUsahaModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Bantuan Usaha');
    }
  }
}