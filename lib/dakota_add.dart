
//import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/Services/api/dakota.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addaddressmapper.dart';
//import 'package:provider/provider.dart';

class DakotaAdd extends StatefulWidget {
  final String latitude;
  final String longtitude;
  DakotaAdd({this.latitude, this.longtitude});
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

  bool asTabs = false;
  String jenisLahan = 'pilih salah satu jenis lahan';
  String bidangUsaha = 'pilih salah satu bidang usaha';
  String subBidangUsahaa = 'pilih salah satu detail usaha';
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
    'Cabai kecil',
    'Caba besar',
    'Bawang merah',
    'Tomat',
    'Wortel',
    'Pisang',
    'Jeruk',
    'Melon',
    'Semangka',
    'lainnya'
  ];

  final List<String> biofarmaka = [
    'Jahe',
    'Kunyit',
    'Laos',
    'lainnya'
  ];

  final List<String> perkebunan = [
    'Tebu',
    'Tembakau virginia',
    'Tembakau jawa',
    'Kopi robusta',
    'Kopi arabica',
    'Kakao',
    'Kelapa',
    'Cengkeh',
    'lainnya'
  ];

  final List<String> peternakan = [
    'Sapi',
    'Kambing',
    'Ayam petelur',
    'Ayam Pedaging',
    'lainnya'
  ];

  final List<String> perikanan = [
    'Lele',
    'Gurami',
    'Nila',
    'Patin',
    'Ikan hias',
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Tambah Data Kelompok Tani'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05, top: height * 0.04),
        child: buildSingleChildScrollView(width, height, context, authProvider),
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(double width, double height, BuildContext context, AuthProvider authProvider) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                FlatButton(onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddAddressMapper())
                  );
                }, child: Text('tentukan lokasi alamat di peta', style: TextStyle(color: Colors.blueAccent),))
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.zoom_out_map),
                Container(
                  margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4.5),
                  child: DropdownButton<String>(
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
                  margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4.5),
                  child: DropdownButton<String>(
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
                ),
              ],
            ),
            Divider(),
            Row(
              children: <Widget>[
                Icon(Icons.zoom_in),
                Container(
                  margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4.5),
                  child: DropdownButton<String>(
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
            FlatButton(onPressed: ()async{
              DakotaApi.createDakota(context,authProvider, _namacontroller.text,_namacontroller.text,alamatcontroller.text,_kecamatancontroller.text
                  ,_kelurahandesacontroller.text,widget.latitude,widget.longtitude,_namaketuacontroller.text,int.parse(_jumlahanggota.text),
                  jenisLahan,int.parse(_luaslahancontroller.text),bidangUsaha,subBidangUsahaa);
            }, child: Text('submit'))
          ],
        ),
      );
  }
}

