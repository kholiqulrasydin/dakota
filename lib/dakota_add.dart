import 'package:dakota/Services/api/dakota.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/home.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';


import 'addaddressmapper.dart';
//import 'package:provider/provider.dart';

class DakotaAdd extends StatefulWidget {
  final String namaKelompok;
  final String namaKetua;
  final String alamat;
  final String kelurahan;
  final String kecamatan;
  final String jumlahAnggota;
  final String luasLahan;
  final String latitude;
  final String longtitude;
  final String jenisLahan;
  final String bidangUsaha;
  final String subBidangUsaha;

  const DakotaAdd({Key key, this.namaKelompok = 'n', this.namaKetua = 'n', this.alamat = 'n', this.kelurahan = 'n', this.kecamatan = 'n', this.jumlahAnggota = 'n', this.luasLahan = 'n', this.latitude = 'n', this.longtitude = 'n', this.jenisLahan = 'n', this.bidangUsaha = 'n', this.subBidangUsaha});
  @override
  _DakotaAddState createState() => _DakotaAddState();
}

class _DakotaAddState extends State<DakotaAdd> {
  TextEditingController _namacontroller = TextEditingController();
  TextEditingController _namaketuacontroller = TextEditingController();
  TextEditingController alamatcontroller = TextEditingController();
  TextEditingController _kelurahandesacontroller = TextEditingController();
  TextEditingController _kecamatancontroller = TextEditingController();
  TextEditingController _jumlahanggota = TextEditingController();
  TextEditingController _luaslahancontroller = TextEditingController();
  TextEditingController subBidangUsahaLainnya = TextEditingController();

  String latitude = '-7.8840868', longtitude = '111.4718637', alamat = 'tentukan lokasi di peta';
  bool asTabs = false;
  String jenisLahan = 'pilih salah satu jenis lahan';
  String bidangUsaha = 'pilih salah satu bidang usaha';
  String subBidangUsahaa;
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
    super.initState();
    setState(() {
      subBidangUsahaa = 'pilih salah satu detail usaha';
    });
      setState(() {
        if(widget.subBidangUsaha != 'n'){
          subBidangUsahaa = widget.subBidangUsaha;
        }else{
          subBidangUsahaa = 'pilih salah satu detail bidang usaha';
        }
        if(widget.namaKelompok != 'n') {_namacontroller = new TextEditingController(text: widget.namaKelompok);}
        if(widget.namaKetua != 'n') { _namaketuacontroller = new TextEditingController(text: widget.namaKetua);}
        if(widget.alamat != 'n') {alamatcontroller = new TextEditingController(text: widget.alamat);}
        if(widget.kelurahan != 'n') {_kelurahandesacontroller = new TextEditingController(text: widget.kelurahan);}
        if(widget.kecamatan != 'n') {_kecamatancontroller = new TextEditingController(text: widget.kecamatan);}
        if(widget.jumlahAnggota != 'n') {_jumlahanggota = new TextEditingController(text: widget.jumlahAnggota);}
        if(widget.luasLahan != 'n') {_luaslahancontroller = new TextEditingController(text: widget.luasLahan);}
        if(widget.latitude != 'n'){latitude = widget.latitude;}
        if(widget.longtitude !='n'){longtitude = widget.longtitude; }
        if(widget.bidangUsaha != 'n'){bidangUsaha = widget.bidangUsaha;}
        if(widget.subBidangUsaha != 'n'){subBidangUsahaa = widget.subBidangUsaha;}
        if(widget.subBidangUsaha == 'lainnya'){
          subBidangUsahaLainnya = new TextEditingController(text: widget.subBidangUsaha);
        }
      });
    if(widget.latitude != 'n' && widget.longtitude !='n'){mapSetter();}
  }

  mapSetter()async{
    final coordinates = new Coordinates(double.parse(latitude), double.parse(longtitude));
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;
    setState(() {
      alamat = first.addressLine;
    });
    print('alamat anda ${first.addressLine}');
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
            }),
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
                      MaterialPageRoute(builder: (context) => AddAddressMapper(namaKelompok: _namacontroller.text, namaKetua: _namaketuacontroller.text, alamat: alamatcontroller.text, kelurahan: _kelurahandesacontroller.text, kecamatan: _kecamatancontroller.text, jumlahAnggota: _jumlahanggota.text, luasLahan: _luaslahancontroller.text, jenisLahan: jenisLahan, bidangUsaha: bidangUsaha, subBidangUsaha: subBidangUsahaa))
                  );
                }, child: SafeArea(child: Text('lokasi kelompok: $alamat', overflow: TextOverflow.fade, style: TextStyle(color: Colors.blueAccent),)))
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
                controller: subBidangUsahaLainnya,
                onChanged: (_val){
                  setState(() {
                    subBidangUsahaa = _val;
                  });
                },
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
                  ,_kelurahandesacontroller.text,latitude,longtitude,_namaketuacontroller.text,int.parse(_jumlahanggota.text),
                  jenisLahan,int.parse(_luaslahancontroller.text),bidangUsaha,subBidangUsahaa);
            }, child: Text('submit'))
          ],
        ),
      );
  }
}

