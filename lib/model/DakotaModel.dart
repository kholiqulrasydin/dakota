class DakotaModel{
  int id;
  String namaKelompok;
  String nomorRegister;
  String alamat;
  String kecamatan;
  String kelurahan;
  String geoLatitude;
  String geoLongtitude;
  String namaKetua;
  int jumlahLaki;
  int jumlahPerempuan;
  int luasSawah;
  int luasTegal;
  int luasPekarangan;
  String bidangUsaha;
  String subBidangUsaha;

  DakotaModel({this.id,this.namaKelompok,this.nomorRegister,this.alamat,this.kecamatan
    ,this.kelurahan,this.geoLatitude, this.geoLongtitude,this.namaKetua, this.jumlahLaki, this.jumlahPerempuan,this.luasSawah, this.luasTegal, this.luasPekarangan,this.bidangUsaha,this.subBidangUsaha,});

  factory DakotaModel.fromJson(Map<String, dynamic> json) {
    return DakotaModel(
      id: json['id'],
      namaKelompok: json['nama_kelompok'],
      nomorRegister: json['nomor_register'],
      alamat: json['alamat'],
      kecamatan: json['kecamatan'],
      kelurahan: json['kelurahan'],
      geoLatitude: json['geo_latitude'],
      geoLongtitude: json['geo_longtitude'],
      namaKetua: json['nama_ketua'],
      jumlahLaki: json['jml_agt_lk'],
      jumlahPerempuan: json['jml_agt_pr'],
      luasSawah: json['luas_sawah'],
      luasTegal: json['luas_tegal'],
      luasPekarangan: json['luas_pekarangan'],
      bidangUsaha: json['bidang_usaha'],
      subBidangUsaha: json['sub_bidang_usaha'],
    );
  }


}