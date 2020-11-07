import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class DakotaAdd extends StatefulWidget {
  @override
  _DakotaAddState createState() => _DakotaAddState();
}

class _DakotaAddState extends State<DakotaAdd> {


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



    Map<String, Widget> widgets;
    widgets = {
      "Pilih Jenis Lahan": SearchableDropdown.single(
        items: ListJenisLahan.list.map((exNum) {
          return (DropdownMenuItem(
              child: Text(exNum.numberString), value: exNum.numberString));
        }).toList(),
        value: ListJenisLahan,
        hint: "Pilih Satu Jenis",
        searchHint: "Cari Jenis Alamat",
        onChanged: (value) {
          setState(() {
            jenisLahan = value;
          });
        },
        dialogBox: true,
        isExpanded: true,
      ),
    };

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
              FlatButton(onPressed: (){}, child: Text('submit'))
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
