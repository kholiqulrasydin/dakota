import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class DakotaModel{
  int id;
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

  DakotaModel({this.id,this.nama_kelompok,this.nomor_register,this.alamat,this.kecamatan
    ,this.kelurahan,this.geo,this.nama_ketua,this.jumlah_anggota,this.jenis_lahan
    ,this.luas_lahan,this.bidang_usaha,this.sub_bidang_usaha,});

  factory DakotaModel.fromJson(Map<String, dynamic> json) {
    return DakotaModel(
      id: json['id'],
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


}