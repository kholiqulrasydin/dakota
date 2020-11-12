import 'package:dakota/Services/api/dakota.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/model/DakotaModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DakotaEdit extends StatelessWidget {

  final List<DakotaModel> listDakota;
  DakotaEdit(this.listDakota);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perbarui Informasi'),
      ),
      body: Center(
        child: DakotaEditingForm(listDakota),
      )
    );
  }
}

class DakotaEditingForm extends StatefulWidget {
  final List<DakotaModel> listDakota;
  DakotaEditingForm(this.listDakota);

  @override
  _DakotaEditingFormState createState() => _DakotaEditingFormState();
}

class _DakotaEditingFormState extends State<DakotaEditingForm> {

  TextEditingController _namacontroller = TextEditingController();
  TextEditingController _namaketuacontroller = TextEditingController();
  TextEditingController _alamatcontroller = TextEditingController();
  TextEditingController _kelurahandesacontroller = TextEditingController();
  TextEditingController _kecamatancontroller = TextEditingController();
  TextEditingController _jumlahanggota = TextEditingController();
  TextEditingController _luaslahancontroller = TextEditingController();

  void initEdit(){
    final dData = widget.listDakota.first;

    print(dData.toString());
    _namacontroller.text = new TextEditingController(text: dData.namaKelompok) as String;
    _namaketuacontroller = new TextEditingController(text: dData.namaKetua);
    _alamatcontroller = new TextEditingController(text: dData.alamat);
    _kelurahandesacontroller = new TextEditingController(text: dData.kelurahan);
    _kecamatancontroller = new TextEditingController(text: dData.kecamatan);
    _jumlahanggota = new TextEditingController(text: dData.jumlahAnggota.toString());
    _luaslahancontroller = new TextEditingController(text: dData.luasLahan.toString());
    setState(() {
      jenisLahan = dData.jenisLahan;
      bidangUsaha = dData.bidangUsaha;
      subBidangUsahaa = dData.subBidangUsaha;
    });
  }

  String jenisLahan;
  String bidangUsaha;
  String subBidangUsahaa;
  bool boolLainnya = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initEdit();
  }


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


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
                controller: _alamatcontroller,
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
              FlatButton(onPressed: ()async{
                DakotaApi.createDakota(context,authProvider, _namacontroller.text,_namacontroller.text,_alamatcontroller.text,_kecamatancontroller.text
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

