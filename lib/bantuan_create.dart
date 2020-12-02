import 'package:dakota/Services/api/bantuan_usaha.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/Services/providers/dakota.dart';
import 'package:dakota/animations/dialog_box.dart';
import 'package:dakota/animations/form_input.dart';
import 'package:dakota/animations/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dakota/Services/api/dakota.dart';

import 'animations/sizeconfig.dart';

class BantuanCreate extends StatefulWidget {
  final int id;

  BantuanCreate(this.id);

  @override
  _BantuanCreateState createState() => _BantuanCreateState();
}

class _BantuanCreateState extends State<BantuanCreate> {
  String jenisBantuan = '';
  String detailBantuan = '';
  String status = '';
  bool jenisBantuanLainnya = false;
  bool statusBelum = false;
  String keterangan = '';
  bool notLoading = true;

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
    var scrWidth = MediaQuery.of(context).size.width;

    return Loader(
      inAsyncCall: !notLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 1.0, top: 10),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                  ),
                                  onPressed: () => Navigator.of(context).pop()),
                              Text(
                                'Tambah data bantuan usaha',
                                style: TextStyle(
                                  fontFamily: 'Cardo',
                                  fontSize: SizeConfig.textMultiplier * 2.5,
                                  color: Color(0xff0C2551),
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          //
                        ),
                      ),
                      //
                      SizedBox(
                        height: 30,
                      ),
                      //
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 50.0, bottom: 8),
                              child: Text(
                                'Bidang Usaha',
                                style: TextStyle(
                                  fontFamily: 'Product Sans',
                                  fontSize: 15,
                                  color: Color(0xff8f9db5),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          //
                          Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 5),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 27, horizontal: 25),
                                decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.grey[350]),
                                      bottom:
                                          BorderSide(color: Colors.grey[350]),
                                      left: BorderSide(color: Colors.grey[350]),
                                      right:
                                          BorderSide(color: Colors.grey[350])),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Pilih salah satu'),
                                    DropdownButton(
                                        hint: Text(
                                          jenisBantuan,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
                                                  detailBantuan =
                                                      '';
                                                });
                                                break;

                                              case "sarpras":
                                                setState(() {
                                                  jenisBantuanList = sarpras;
                                                  detailBantuan =
                                                      '';
                                                });
                                                break;

                                              case "bibit":
                                                setState(() {
                                                  jenisBantuanList = bibit;
                                                  detailBantuan =
                                                      '';
                                                });
                                                break;

                                              case "ternak":
                                                setState(() {
                                                  jenisBantuanList = ternak;
                                                  detailBantuan =
                                                      '';
                                                });
                                                break;

                                              case "perikanan":
                                                setState(() {
                                                  jenisBantuanList = perikanan;
                                                  detailBantuan =
                                                      '';
                                                });
                                                break;
                                            }
                                          });
                                        })
                                  ],
                                ),
                              )),
                          //
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      jenisBantuanLainnya
                          ? Column(children: <Widget>[
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 50.0, bottom: 8),
                                      child: Text(
                                        'Jenis bantuan lainnya',
                                        style: TextStyle(
                                          fontFamily: 'Product Sans',
                                          fontSize: 15,
                                          color: Color(0xff8f9db5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(40, 0, 40, 5),
                                    child: TextFormField(
                                      controller: namaBantuanController,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Color(0xff0962ff),
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        hintText:
                                            'Isikan jenis bantuan usaha lainnya',
                                        hintStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[350],
                                            fontWeight: FontWeight.w600),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 10),
                                        focusColor: Color(0xff0962ff),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Color(0xff0962ff)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: Colors.grey[350],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ])
                          : Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50.0, bottom: 8),
                                    child: Text(
                                      'Detail bantuan usaha',
                                      style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        fontSize: 15,
                                        color: Color(0xff8f9db5),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(40, 0, 40, 5),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 27, horizontal: 25),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey[350]),
                                            bottom: BorderSide(
                                                color: Colors.grey[350]),
                                            left: BorderSide(
                                                color: Colors.grey[350]),
                                            right: BorderSide(
                                                color: Colors.grey[350])),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('Pilih salah satu'),
                                          DropdownButton(
                                              hint: Text(
                                                detailBantuan,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              items: jenisBantuanList
                                                  .map((String value) {
                                                return new DropdownMenuItem<
                                                    String>(
                                                  value: value,
                                                  child: new Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (_val) {
                                                setState(() {
                                                  detailBantuan = _val;
                                                });
                                              })
                                        ],
                                      ),
                                    )),
                                //
                              ],
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 50.0, bottom: 8),
                              child: Text(
                                'Status bantuan',
                                style: TextStyle(
                                  fontFamily: 'Product Sans',
                                  fontSize: 15,
                                  color: Color(0xff8f9db5),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding:
                              const EdgeInsets.fromLTRB(40, 0, 40, 5),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 27, horizontal: 25),
                                decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.grey[350]),
                                      bottom: BorderSide(
                                          color: Colors.grey[350]),
                                      left: BorderSide(
                                          color: Colors.grey[350]),
                                      right: BorderSide(
                                          color: Colors.grey[350])),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Pilih salah satu'),
                                    DropdownButton(
                                        hint: Text(
                                          status,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        items: <String>['pernah', 'belum pernah']
                                            .map((String value) {
                                          return new DropdownMenuItem<
                                              String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (_val) {
                                          setState(() {
                                            status = _val;
                                          });
                                        })
                                  ],
                                ),
                              )),
                        ],
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      jenisBantuanLainnya ?
                      Column(
                        children: <Widget>[
                          FormInputDesign(
                            controller: detailBantuanController,
                            label: 'Detail bantuan lainnya',
                            inputHint: 'Isikan detail bantuan lainnya',
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ) : SizedBox(
                        height: 0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FormInputDesign(
                        controller: jumlahBantuanController,
                        label: 'Jumlah bantuan',
                        inputHint: '5 (Paket)',
                        textInputType: TextInputType.number,
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 50.0, bottom: 8),
                              child: Text(
                                'Keterangan',
                                style: TextStyle(
                                  fontFamily: 'Product Sans',
                                  fontSize: 15,
                                  color: Color(0xff8f9db5),
                                ),
                              ),
                            ),
                          ),
                          //
                          Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 5),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 27, horizontal: 25),
                                decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.grey[350]),
                                      bottom:
                                      BorderSide(color: Colors.grey[350]),
                                      left: BorderSide(color: Colors.grey[350]),
                                      right:
                                      BorderSide(color: Colors.grey[350])),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Pilih salah satu'),
                                    DropdownButton(
                                        hint: Text(
                                          keterangan,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        items: <String>['APBN', 'APBD I', 'APBD II', 'Menunggu Keputusan'].map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (_val) {
                                          setState(() {
                                            keterangan = _val;
                                          });
                                        })
                                  ],
                                ),
                              )),
                          //
                        ],
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      FormInputDesign(
                        controller: tahunController,
                        label: 'Keterangan tahun',
                        inputHint: '1994',
                        textInputType: TextInputType.number,
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      //
                      Text(
                        "Sebelum menyimpan data baru,\npastikan data yang anda masukan sesuai",
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff8f9db5).withOpacity(0.45),
                        ),
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        //
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            notLoading = false;
                          });
                          BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context, listen: false);
                          DakotaProvider dakotaProvider = Provider.of<DakotaProvider>(context, listen: false);
                          if (jenisBantuanLainnya) {
                            await BantuanUsahaApi.createData(context, bantuanUsaha, dakotaProvider, widget.id, namaBantuanController.text, detailBantuanController.text, status, int.parse(jumlahBantuanController.text), tahunController.text.toString(), keterangan)
                                .then((value) {
                              Widget showFunction;
                              if (value == 200) {
                                setState(() {
                                  notLoading = true;
                                });
                                showFunction = DialogBox(
                                    title: 'Sukses',
                                    description:
                                    'Selamat! Bantuan usaha telah ditambahkan, silahkan tekan tombol konfirmasi untuk menuju halaman profil kelompok',
                                    buttonText: 'konfirmasi',
                                    image: 'assets/success.gif',
                                    onPressed: () => DakotaApi.getPersonalGroup(context, dakotaProvider, widget.id, bantuanUsaha));
                              } else if (value == 500) {
                                setState(() {
                                  notLoading = true;
                                });
                                DialogBox(
                                  title: 'Gagal',
                                  description:
                                  'Terjadi kesalahan data. silahkan tekan tombol kembali',
                                  buttonText: 'kembali',
                                  image: 'assets/failed.gif',
                                );
                              }
                              return showDialog(
                                  context: context,
                                  builder: (context) => showFunction);
                            });
                          }else {
                            await BantuanUsahaApi.createData(context, bantuanUsaha, dakotaProvider, widget.id, jenisBantuan, detailBantuan, status, int.parse(jumlahBantuanController.text), tahunController.text, keterangan)
                                .then((value) {
                              Widget showFunction;
                              if (value == 200) {
                                setState(() {
                                  notLoading = true;
                                });
                                showFunction = DialogBox(
                                    title: 'Sukses',
                                    description:
                                    'Selamat! Bantuan usaha telah ditambahkan, silahkan tekan tombol konfirmasi untuk menuju halaman profil kelompok',
                                    buttonText: 'konfirmasi',
                                    image: 'assets/success.gif',
                                    onPressed: () => DakotaApi.getPersonalGroup(context, dakotaProvider, widget.id, bantuanUsaha));
                              } else if (value == 500) {
                                setState(() {
                                  notLoading = true;
                                });
                                DialogBox(
                                  title: 'Gagal',
                                  description:
                                  'Terjadi kesalahan data. silahkan tekan tombol kembali',
                                  buttonText: 'kembali',
                                  image: 'assets/failed.gif',
                                );
                              }
                              return showDialog(
                                  context: context,
                                  builder: (context) => showFunction);
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: scrWidth * 0.85,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xff0962ff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Tambahkan bantuan',
                              style: TextStyle(
                                fontFamily: 'ProductSans',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class Neu_button extends StatelessWidget {
  Neu_button({this.char});

  String char;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(12, 11),
            blurRadius: 26,
            color: Color(0xffaaaaaa).withOpacity(0.1),
          )
        ],
      ),
      //
      child: Center(
        child: Text(
          char,
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: Color(0xff0962FF),
          ),
        ),
      ),
    );
  }
}

class OuterClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 4);
    //
    path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class InnerClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);
    //
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.11, size.width * 0.7, 0);

    //
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
