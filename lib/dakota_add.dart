import 'dart:async';
import 'dart:convert';
import 'package:dakota/Services/auth.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
//import 'package:searchable_dropdown/searchable_dropdown.dart';
//create data
Future<DakotaModel> createDakota(AuthProvider authProvider,String nama_kelompok,String nomor_register,String alamat
    ,String kecamatan,String kelurahan,String geo_latitude,String geo_longtitude,
    String nama_ketua,int jumlah_anggota,
    String jenis_lahan,int luas_lahan,String bidang_usaha
    ,String sub_bidang_usaha) async {
  print(authProvider.currentToken);
  final http.Response response = await http.post(
    'http://apidinper.reboeng.com/api/dakota',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${authProvider.currentToken}'
    },
    body: jsonEncode(<String, String>{
      'nama_kelompok': nama_kelompok,
      'nomor_register': nomor_register,
      'alamat': alamat,
      'kecamatan': kecamatan,
      'kelurahan': kelurahan,
      'geo_latitude': geo_latitude,
      'geo_longtitude': geo_longtitude,
      'nama_ketua': nama_ketua,
      'jumlah_anggota': jumlah_anggota.toString(),
      'jenis_lahan': jenis_lahan,
      'luas_lahan': luas_lahan.toString(),
      'bidang_usaha': bidang_usaha,
      'sub_bidang_usaha': sub_bidang_usaha,

    }),
  );

  print(response.statusCode.toString());
  if (response.statusCode == 200) {
    return DakotaModel.fromJson(jsonDecode(response.body));
  } else {
    print('Failed To Create Dakota');
  }
}
//update data
Future<DakotaModel> updateDakota(String nama_kelompok,String nomor_register,String alamat
    ,String kecamatan,String kelurahan,String geo,
    String nama_ketua,int jumlah_anggota,
    String jenis_lahan,int luas_lahan,String bidang_usaha
    ,String sub_bidang_usaha) async {
  final http.Response response = await http.put(
    'http://apidinper.reboeng.com/api/dakota/1}',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nama_kelompok': nama_kelompok,
      'nomor_register': nomor_register,
      'alamat': alamat,
      'kecamatan': kecamatan,
      'kelurahan': kelurahan,
      'geo_latitude': geo,
      'geo_longtitude': geo,
      'nama_ketua': nama_ketua,
      'jumlah_anggota': jumlah_anggota.toString(),
      'jenis_lahan': jenis_lahan,
      'luas_lahan': luas_lahan.toString(),
      'bidang_usaha': bidang_usaha,
      'sub_bidang_usaha': sub_bidang_usaha,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DakotaModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update Dakota.');
  }
}
//delete data
Future<DakotaModel> deleteDakota(String id) async {
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
    return DakotaModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete Dakota.');
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
class DakotaModel{
  final int id;
  final String nama_kelompok;
  final String nomor_register;
  final String alamat;
  final String kecamatan;
  final String kelurahan;
  final String geo_latitude;
  final String geo_longtitude;
  final String nama_ketua;
  final int jumlah_anggota;
  final String jenis_lahan;
  final int luas_lahan;
  final String bidang_usaha;
  final String sub_bidang_usaha;

  DakotaModel({this.id,this.nama_kelompok,this.nomor_register,this.alamat,this.kecamatan
    ,this.kelurahan,this.geo_latitude,this.geo_longtitude,this.nama_ketua,this.jumlah_anggota,this.jenis_lahan
    ,this.luas_lahan,this.bidang_usaha,this.sub_bidang_usaha,});

  factory DakotaModel.fromJson(Map<String, dynamic> json) {
    return DakotaModel(
      id: json['id'],
      nama_kelompok: json['nama_kelompok'],
      nomor_register: json['nomor_register'],
      alamat: json['alamat'],
      kecamatan: json['kecamatan'],
      kelurahan: json['kelurahan'],
      geo_latitude: json['geo_latitude'],
      geo_longtitude: json['geo_longtitude'],
      nama_ketua: json['nama_ketua'],
      jumlah_anggota: json['jumlah_anggota'],
      jenis_lahan: json['jenis_lahan'],
      luas_lahan: json['luas_lahan'],
      bidang_usaha: json['bidang_usaha'],
      sub_bidang_usaha: json['sub_bidang_usaha'],
    );
  }


}
class DakotaAdd extends StatefulWidget {
  @override
  _DakotaAddState createState() => _DakotaAddState();
}

class _DakotaAddState extends State<DakotaAdd> {
  final TextEditingController _namacontroller = TextEditingController();
  final TextEditingController _namaketuacontroller = TextEditingController();
  final TextEditingController alamatcontroller = TextEditingController();
  final TextEditingController _kelurahandesacontroller = TextEditingController();
  final TextEditingController _kecamatancontroller = TextEditingController();
  final TextEditingController _jumlahanggota = TextEditingController();
  final TextEditingController _luaslahancontroller = TextEditingController();
  Future<DakotaModel> _futureDakota;

  bool asTabs = false;
  String jenisLahan = 'pilih salah satu';
  String bidangUsaha = 'pilih salah satu';
  String subBidangUsahaa = 'pilih salah satu';
  bool boolLainnya = false;
  final List<DropdownMenuItem> items = [];
  final List<String> tanamanPangan = [
    'Padi',
    'Jagung',
    'Kedelai',
    'Kacang Tanah',
    'Ubi Kayu',
    'lainnya'
  ];

  final List<String> hortikultura = [
    'Padi',
    'Jagung',
    'Kedelai',
    'Kacang Tanah',
    'Ubi Kayu',
    'lainnya'
  ];

  final List<String> biofarmaka = [
    'Padi',
    'Jagung',
    'Kedelai',
    'Kacang Tanah',
    'Ubi Kayu',
    'lainnya'
  ];

  final List<String> perkebunan = [
    'Padi',
    'Jagung',
    'Kedelai',
    'Kacang Tanah',
    'Ubi Kayu',
    'lainnya'
  ];

  final List<String> peternakan = [
    'Padi',
    'Jagung',
    'Kedelai',
    'Kacang Tanah',
    'Ubi Kayu',
    'lainnya'
  ];

  final List<String> perikanan = [
    'lele',
    'Jagung',
    'Kedelai',
    'Kacang Tanah',
    'Ubi Kayu',
    'lainnya'
  ];

  List<String> subBidangUsaha = [];

  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  List<Widget> get appBarActions {
    return ([
      Center(child: Text("Tabs:")),
      Switch(
        activeColor: Colors.white,
        value: asTabs,
        onChanged: (value) {
          setState(() {
            asTabs = value;
          });
        },
      )
    ]);
  }

  @override
  void initState() {
    String wordPair = "";
    loremIpsum
        .toLowerCase()
        .replaceAll(",", "")
        .replaceAll(".", "")
        .split(" ")
        .forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = word + " ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
          return (item.value == wordPair);
        }) ==
            -1) {
          items.add(DropdownMenuItem(
            child: Text(wordPair),
            value: wordPair,
          ));
        }
        wordPair = "";
      }
    });

    lainnyaInput = Text('');
    super.initState();
  }

  Widget lainnyaInput;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    AuthProvider authProvider = Provider.of<AuthProvider>(context);

//    Map<String, Widget> widgets;
//    widgets = {
//      "Pilih Jenis Lahan": SearchableDropdown.single(
//        items: ListJenisLahan.list.map((exNum) {
//          return (DropdownMenuItem(
//              child: Text(exNum.numberString), value: exNum.numberString));
//        }).toList(),
//        value: ListJenisLahan,
//        hint: "Pilih Satu Jenis",
//        searchHint: "Cari Jenis Alamat",
//        onChanged: (value) {
//          setState(() {
//            jenisLahan = value;
//          });
//        },
//        dialogBox: true,
//        isExpanded: true,
//      ),
//    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Tambah Data Kelompok Tani'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05, top: height * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _namacontroller,
                style:
                TextStyle(fontSize: 17.0, color: Colors.blueGrey),
                decoration: InputDecoration(
                    icon: Icon(Icons.apps), labelText: 'Nama Kelompok Tani'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Divider(),
              TextField(
                controller: _namaketuacontroller,
                style:
                TextStyle(fontSize: 17.0, color: Colors.blueGrey),
                decoration: InputDecoration(
                    icon: Icon(Icons.person), labelText: 'Nama Ketua'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Divider(),
              TextField(
                controller: alamatcontroller,
                style:
                TextStyle(fontSize: 17.0, color: Colors.blueGrey),
                decoration: InputDecoration(
                    icon: Icon(Icons.weekend), labelText: 'Alamat'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Divider(),
              TextField(
                controller: _kelurahandesacontroller,
                style:
                TextStyle(fontSize: 17.0, color: Colors.blueGrey),
                decoration: InputDecoration(
                    icon: Icon(Icons.account_balance), labelText: 'Kelurahan / Desa'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Divider(),
              TextField(
                controller: _kecamatancontroller,
                style:
                TextStyle(fontSize: 17.0, color: Colors.blueGrey),
                decoration: InputDecoration(
                    icon: Icon(Icons.arrow_forward), labelText: 'Kecamatan'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Icon(Icons.map),
                  FlatButton(onPressed: (){}, child: Text('tentukan lokasi alamat di peta', style: TextStyle(color: Colors.blueAccent),))
                ],
              ),
              Divider(),
              TextField(
                controller: _jumlahanggota,
                keyboardType: TextInputType.number,
                style:
                TextStyle(fontSize: 17.0, color: Colors.blueGrey),
                decoration: InputDecoration(
                    icon: Icon(Icons.wc), labelText: 'Jumlah Anggota'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Icon(Icons.zoom_out_map),
                  Container(
                    margin: EdgeInsets.only(left: width * 0.04, right: width * 0.01),
                    child: Text('Jenis Lahan '),
                  ),
                  DropdownButton<String>(
                    hint: Text('$jenisLahan'),
                    items: <String>['sawah', 'non-sawah(tegal/kebun)'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_val) {
                      setState(() {
                        jenisLahan = _val;
                      });
                    },
                  ),
                ],
              ),
              Divider(),
              TextField(
                controller: _luaslahancontroller,
                keyboardType: TextInputType.number,
                style:
                TextStyle(fontSize: 17.0, color: Colors.blueGrey),
                decoration: InputDecoration(
                    icon: Icon(Icons.launch), labelText: 'Luas Lahan (meter)'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Icon(Icons.accessibility),
                  Container(
                    margin: EdgeInsets.only(left: width * 0.04, right: width * 0.01),
                    child: Text('Bidang Usaha '),
                  ),
                  DropdownButton<String>(
                    hint: Text('$bidangUsaha'),
                    items: <String>['Tanaman Pangan', 'Hortikultura', 'Biofarmaka', 'Perkebunan', 'Peternakan', 'Perikanan'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_val) {
                      setState(() {
                        bidangUsaha = _val;
                        subBidangUsaha = [];
                      });
                      switch(_val){
                        case "Tanaman Pangan":
                          setState(() {
                            subBidangUsaha = tanamanPangan;
                            subBidangUsahaa = 'pilih salah satu';
                          });
                          break;

                        case "Hortikultura":
                          setState(() {
                            subBidangUsaha = hortikultura;
                            subBidangUsahaa = 'pilih salah satu';
                          });
                          break;

                        case "Biofarmaka":
                          setState(() {
                            subBidangUsaha = biofarmaka;
                            subBidangUsahaa = 'pilih salah satu';
                          });
                          break;

                        case "Perkebunan":
                          setState(() {
                            subBidangUsaha = perkebunan;
                            subBidangUsahaa = 'pilih salah satu';
                          });
                          break;

                        case "Peternakan":
                          setState(() {
                            subBidangUsaha = peternakan;
                            subBidangUsahaa = 'pilih salah satu';
                          });
                          break;

                        case "Perikanan":
                          setState(() {
                            subBidangUsaha = perikanan;
                            subBidangUsahaa = 'pilih salah satu';
                          });
                          break;
                      }
                    },
                  ),
                ],
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Icon(Icons.zoom_in),
                  Container(
                    margin: EdgeInsets.only(left: width * 0.04, right: width * 0.01),
                    child: Text('Detail Bidang Usaha '),
                  ),
                  DropdownButton<String>(
                    hint: Text('$subBidangUsahaa'),
                    items: subBidangUsaha.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_val) {
                      setState(() {
                        subBidangUsahaa = _val;
                      });
                      if(_val == 'lainnya'){
                        setState(() {
                          boolLainnya = true;
                        });
                      }
                    },
                  ),
                ],
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(bottom: height * 0.01),
                child: (boolLainnya) ? TextField(
                  keyboardType: TextInputType.text,
                  style:
                  TextStyle(fontSize: 17.0, color: Colors.blueGrey),
                  decoration: InputDecoration(
                      icon: Icon(Icons.zoom_in), labelText: 'Detail Usaha Lainnya'),
                ) : Text(''),
              ),
              Divider(),
              FlatButton(onPressed: (){
                createDakota(authProvider, _namacontroller.text,_namacontroller.text,alamatcontroller.text,_kecamatancontroller.text
                    ,_kelurahandesacontroller.text,'-7,1343857','8,2353287',_namaketuacontroller.text,int.parse(_jumlahanggota.text),
                    jenisLahan,int.parse(_luaslahancontroller.text),bidangUsaha,subBidangUsahaa);
              }, child: Text('submit'))
            ],
          ),
        ),
      ),
    );
  }
}

class ListJenisLahan{
  int number;

  static final Map<int, String> map = {
    0: "sawah",
    1: "non-sawah",
  };

  String get numberString {
    return (map.containsKey(number) ? map[number] : "unknown");
  }

  ListJenisLahan(this.number);

  String toString() {
    return ("$number $numberString");
  }

  static List<ListJenisLahan> get list {
    return (map.keys.map((num) {
      return (ListJenisLahan(num));
    })).toList();
  }
}
