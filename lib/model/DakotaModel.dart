import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class DakotaModel{
  String nama_kelompok;
  String nomor_register;
  String alamat;
  String kecamatan;
  String kelurahan;
  String geo;
  String nama_ketua;
  int jumlah_anggota;
  String jenis_lahan;
  int luas_lahan;
  String bidang_usaha;
  String sub_bidang_usaha;

  DakotaModel({this.nama_kelompok,this.nomor_register,this.alamat,this.kecamatan
    ,this.kelurahan,this.geo,this.nama_ketua,this.jumlah_anggota,this.jenis_lahan
    ,this.luas_lahan,this.bidang_usaha,this.sub_bidang_usaha,});

  factory DakotaModel.fromJson(Map<String, dynamic> json) {
    return DakotaModel(
      nama_kelompok: json['nama_kelompok'],
      nomor_register: json['nomor_register'],
      alamat: json['alamat'],
      kecamatan: json['kecamatan'],
      kelurahan: json['kelurahan'],
      geo: json['geo'],
      nama_ketua: json['nama_ketua'],
      jumlah_anggota: json['jumlah_anggota'],
      jenis_lahan: json['jenis_lahan'],
      luas_lahan: json['luas_lahan'],
      bidang_usaha: json['bidang_usaha'],
      sub_bidang_usaha: json['sub_bidang_usaha'],
    );
  }
  //create data
  Future<DakotaModel> createDakota(String nama_kelompok,String nomor_register,String alamat
      ,String kecamatan,String kelurahan,String geo,
      String nama_ketua,int jumlah_anggota,
      String jenis_lahan,int luas_lahan,String bidang_usaha
      ,String sub_bidang_usaha) async {
    final http.Response response = await http.post(
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nama_kelompok': nama_kelompok,
        'nomor_register': nomor_register,
        'alamat': alamat,
        'kecamatan': kecamatan,
        'kelurahan': kelurahan,
        'geo': geo,
        'nama_ketua': nama_ketua,
        'jumlah_anggota': jumlah_anggota.toString(),
        'jenis_lahan': jenis_lahan,
        'luas_lahan': luas_lahan.toString(),
        'bidang_usaha': bidang_usaha,
        'sub_bidang_usaha': sub_bidang_usaha,

      }),
    );

    if (response.statusCode == 201) {
      return DakotaModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Dakota.');
    }
  }
  //fetch data
  Future<DakotaModel> fetchDakota() async {
    final response =
    await http.get('https://jsonplaceholder.typicode.com/albums/1');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return DakotaModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Dakota');
    }
  }
}