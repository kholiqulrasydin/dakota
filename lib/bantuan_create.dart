import 'package:dakota/Services/api/bantuan_usaha.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/Services/providers/dakota.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'animations/sizeconfig.dart';

class BantuanCreate extends StatefulWidget {
  final int id;

  BantuanCreate(this.id);

  @override
  _BantuanCreateState createState() => _BantuanCreateState();
}

class _BantuanCreateState extends State<BantuanCreate> {
  String jenisBantuan = 'pilih salah satu';
  String detailBantuan = 'pilih salah satu detail bantuan';
  String status = 'pilih salah satu';
  bool jenisBantuanLainnya = false;
  bool statusBelum = false;
  String keterangan = 'pilih salah satu keterangan';

  final TextEditingController jumlahBantuanController = TextEditingController();
  final TextEditingController namaBantuanController = TextEditingController();
  final TextEditingController detailBantuanController = TextEditingController();
  final TextEditingController tahunController = TextEditingController();

  List<String> jenisBantuanList = [];

  final List<String> alsintan = [
    'Handtractor',
    'Handsprayer',
    'Cultivator',
    'Pompa Air',
    'Rice Transplanter',
    'Combine Harvester Besar',
    'Combine Harvester kecil',
    'Cor Sheller',
    'Mesin Perajang',
    'Widig',
    'lainnya'
  ];

  final List<String> sarpras = [
    'Irigasi air tanah/sumur dangkal',
    'Irigasi air tanah/sumur sedang',
    'Irigasi air tanah/sumur dalam',
    'Pembangunan JITUT/JIDES',
    'Rehabilitasi JITUT/JIDES',
    'Rehabilitasi Dam Parit',
    'Embung',
    'Jalan Usaha Tani',
    'lainnya',
  ];

  final List<String> bibit = [
    'Padi',
    'Jagung',
    'Kedelai',
    'Kelapa',
    'Kopi',
    'lainnya'
  ];

  final List<String> ternak = ['Sapi', 'Kambing', 'Ayam', 'lainnya'];

  final List<String> perikanan = [
    'Paket Budidaya Lele',
    'Paket Budidaya Nila',
    'Paket Budidaya Gurami',
    'Paket Budidaya Patin',
    'lainnya'
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Bantuan Usaha'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.accessibility),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4.5),
                    child: Text('Jenis Bantuan '),
                  ),
                  DropdownButton<String>(
                    hint: Text('$jenisBantuan'),
                    items: <String>[
                      'alsintan',
                      'sarpras',
                      'bibit',
                      'ternak',
                      'perikanan',
                      'lainnya'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_val) {
                      setState(() {
                        jenisBantuan = _val;
                        if (_val == 'lainnya') {
                          jenisBantuanLainnya = true;
                        } else {
                          jenisBantuanLainnya = false;
                        }
                        switch (_val) {
                          case "alsintan":
                            setState(() {
                              jenisBantuanList = alsintan;
                              detailBantuan = 'pilih salah satu';
                            });
                            break;

                          case "sarpras":
                            setState(() {
                              jenisBantuanList = sarpras;
                              detailBantuan = 'pilih salah satu';
                            });
                            break;

                          case "bibit":
                            setState(() {
                              jenisBantuanList = bibit;
                              detailBantuan = 'pilih salah satu';
                            });
                            break;

                          case "ternak":
                            setState(() {
                              jenisBantuanList = ternak;
                              detailBantuan = 'pilih salah satu';
                            });
                            break;

                          case "perikanan":
                            setState(() {
                              jenisBantuanList = perikanan;
                              detailBantuan = 'pilih salah satu';
                            });
                            break;
                        }
                      });
                    },
                  ),
                ],
              ),
              Divider(),
              Container(
                child: (jenisBantuanLainnya)
                    ? TextField(
                  controller: namaBantuanController,
                  keyboardType: TextInputType.text,
                  style:
                  TextStyle(fontSize: 17.0, color: Colors.blueGrey),
                  decoration: InputDecoration(
                      icon: Icon(Icons.zoom_in),
                      labelText: 'Nama Bantuan'),
                )
                    : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.zoom_in),
                    Container(
                      margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4),
                      child: DropdownButton<String>(
                        hint: Text('$detailBantuan'),
                        items: jenisBantuanList.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (_val) {
                          setState(() {
                            detailBantuan = _val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Icon(Icons.check),
                  Container(
                    margin: EdgeInsets.only(
                        left: width * 0.04, right: width * 0.01),
                    child: Text('Status Bantuan '),
                  ),
                  DropdownButton<String>(
                    hint: Text('$status'),
                    items:
                    <String>['pernah', 'belum pernah'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_val) {
                      setState(() {
                        status = _val;
                      });
                    },
                  ),
                ],
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(bottom: height * 0.01),
                child: (jenisBantuanLainnya)
                    ? Column(
                  children: <Widget>[
                    TextField(
                      controller: detailBantuanController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 17.0, color: Colors.blueGrey),
                      decoration: InputDecoration(
                          icon: Icon(Icons.zoom_in),
                          labelText: 'Detail Bantuan'),
                    ),
                    Divider(),
                  ],
                )
                    : Text(''),
              ),
              TextField(
                controller: jumlahBantuanController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 17.0, color: Colors.blueGrey),
                decoration: InputDecoration(
                    icon: Icon(Icons.zoom_in), labelText: 'Jumlah (Paket)'),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Icon(Icons.title),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4.5),
                    child: DropdownButton<String>(
                      hint: Text('$keterangan'),
                      items: <String>['APBN', 'APBD I', 'APBD II', 'Menunggu Keputusan']
                          .map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (_val) {
                        setState(() {
                          keterangan = _val;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Divider(),
              TextField(
                controller: tahunController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                style: TextStyle(fontSize: 17.0, color: Colors.blueGrey),
                decoration: InputDecoration(
                    icon: Icon(Icons.access_time), labelText: 'Keterangan Tahun'),
              ),
              Divider(),
              Center(
                child:
                FlatButton(onPressed: () async {
                  BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context, listen: false);
                  DakotaProvider dakotaProvider = Provider.of<DakotaProvider>(context, listen: false);
                  if (jenisBantuanLainnya) {
                    await BantuanUsahaApi.createData(context, bantuanUsaha, dakotaProvider, widget.id, namaBantuanController.text, detailBantuanController.text, status, int.parse(jumlahBantuanController.text), tahunController.text.toString(), keterangan);
                  }else {
                    await BantuanUsahaApi.createData(context, bantuanUsaha, dakotaProvider, widget.id, jenisBantuan, detailBantuan, status, int.parse(jumlahBantuanController.text), tahunController.text, keterangan);
                  }
                }, child: Text('Simpan')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
