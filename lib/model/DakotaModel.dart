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
  int jumlahAnggota;
  String jenisLahan;
  int luasLahan;
  String bidangUsaha;
  String subBidangUsaha;

  DakotaModel({this.id,this.namaKelompok,this.nomorRegister,this.alamat,this.kecamatan
    ,this.kelurahan,this.geoLatitude, this.geoLongtitude,this.namaKetua,this.jumlahAnggota,this.jenisLahan
    ,this.luasLahan,this.bidangUsaha,this.subBidangUsaha,});

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
      jumlahAnggota: json['jumlah_anggota'],
      jenisLahan: json['jenis_lahan'],
      luasLahan: json['luas_lahan'],
      bidangUsaha: json['bidang_usaha'],
      subBidangUsaha: json['sub_bidang_usaha'],
    );
  }


}