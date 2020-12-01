import 'package:dakota/Services/api/dakota.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/animations/dialog_box.dart';
import 'package:dakota/animations/form_input.dart';
import 'package:dakota/animations/loader.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/dakota_viewAll.dart';
import 'package:dakota/home.dart';
import 'package:flutter/cupertino.dart';
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
  final String jumlahAnggotalaki;
  final String jumlahAnggotaPerempuan;
  final String latitude;
  final String longtitude;
  final String bidangUsaha;
  final String subBidangUsaha;
  final String luasSawah;
  final String luasTegal;
  final String luasPekarangan;

  const DakotaAdd({Key key, this.namaKelompok = 'n', this.namaKetua = 'n', this.alamat = 'n', this.kelurahan = 'n', this.kecamatan = 'n', this.jumlahAnggotalaki = 'n', this.jumlahAnggotaPerempuan = 'n', this.latitude = 'n', this.longtitude = 'n', this.bidangUsaha = 'n', this.subBidangUsaha, this.luasTegal = 'n', this.luasSawah = 'n', this.luasPekarangan = 'n'});
  @override
  _DakotaAddState createState() => _DakotaAddState();
}

class _DakotaAddState extends State<DakotaAdd> {
  TextEditingController _namacontroller = TextEditingController();
  TextEditingController _namaketuacontroller = TextEditingController();
  TextEditingController alamatcontroller = TextEditingController();
  TextEditingController _kelurahandesacontroller = TextEditingController();
  TextEditingController _kecamatancontroller = TextEditingController();
  TextEditingController _jumlahAnggotaLakiController = TextEditingController();
  TextEditingController _jumlahAnggotaPerempuanController = TextEditingController();
  TextEditingController _luasSawahController = TextEditingController();
  TextEditingController _luasTegalController = TextEditingController();
  TextEditingController _luasPekaranganController = TextEditingController();
  TextEditingController subBidangUsahaLainnya = TextEditingController();

  String latitude = '-7.8840868', longtitude = '111.4718637', alamat = 'tentukan lokasi di peta';
  bool asTabs = false;
  String bidangUsaha = '';
  String subBidangUsahaa = '';
  bool boolLainnya = false;
  bool notLoading = true;
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
//    setState(() {
//      subBidangUsahaa = 'pilih salah satu detail usaha';
//    });
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
        if(widget.jumlahAnggotalaki != 'n') {_jumlahAnggotaLakiController = new TextEditingController(text: widget.jumlahAnggotalaki);}
        if(widget.jumlahAnggotaPerempuan != 'n') {_jumlahAnggotaPerempuanController = new TextEditingController(text: widget.jumlahAnggotaPerempuan);}
        if(widget.luasSawah != 'n') {_luasSawahController = new TextEditingController(text: widget.luasSawah);}
        if(widget.luasTegal != 'n') {_luasTegalController = new TextEditingController(text: widget.luasTegal);}
        if(widget.luasPekarangan != 'n') {_luasPekaranganController = new TextEditingController(text: widget.luasPekarangan);}
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
    var scrWidth = MediaQuery.of(context).size.width;

    AuthProvider authProvider = Provider.of<AuthProvider>(context);

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
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                                  }),
                              Text(
                                'Tambah Data Kelompok Tani',
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
                      FormInputDesign(
                        controller: _namacontroller,
                        label: 'Nama Kelompok',
                        inputHint: 'Konco Tani',
                        textInputType: TextInputType.text,
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      //
                      FormInputDesign(
                        controller: _namaketuacontroller,
                        label: 'Nama Ketua',
                        inputHint: 'Joko',
                        textInputType: TextInputType.text,
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      FormInputDesign(
                        controller: alamatcontroller,
                        label: 'Alamat',
                        inputHint: 'Jl. inaja no. 4 / Krajan(Dukuh)',
                        textInputType: TextInputType.text,
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      FormInputDesign(
                        controller: _kelurahandesacontroller,
                        label: 'Kelurahan / Desa',
                        inputHint: 'Ronowijayan',
                        textInputType: TextInputType.text,
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      FormInputDesign(
                        controller: _kecamatancontroller,
                        label: 'Kecamatan',
                        inputHint: 'Babadan',
                        textInputType: TextInputType.text,
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.map),
                            Flexible(
                                child: FlatButton(onPressed: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => AddAddressMapper(namaKelompok: _namacontroller.text, namaKetua: _namaketuacontroller.text, alamat: alamatcontroller.text, kelurahan: _kelurahandesacontroller.text, kecamatan: _kecamatancontroller.text, jumlahAnggotalaki: widget.jumlahAnggotalaki, jumlahAnggotaPerempuan: widget.jumlahAnggotaPerempuan, luasSawah: widget.luasSawah, luasPekarangan: widget.luasPekarangan, luasTegal: widget.luasTegal, bidangUsaha: bidangUsaha, subBidangUsaha: subBidangUsahaa))
                                  );
                                }, child: Text('lokasi kelompok: $alamat', overflow: TextOverflow.fade, style: TextStyle(color: Colors.blueAccent),))
                            ),
                          ],
                        ),
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      FormInputDesign(
                        controller: _jumlahAnggotaLakiController,
                        label: 'Jumlah Anggota Laki-laki',
                        inputHint: '55',
                        textInputType: TextInputType.number,
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      FormInputDesign(
                        controller: _jumlahAnggotaPerempuanController,
                        label: 'Jumlah Anggota Perempuan',
                        inputHint: '21',
                        textInputType: TextInputType.number,
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      FormInputDesign(
                        controller: _luasSawahController,
                        label: 'Luas lahan Sawah || isi 0 jika tidak ada',
                        inputHint: '(meter\u00B2)',
                        textInputType: TextInputType.number,
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      FormInputDesign(
                        controller: _luasTegalController,
                        label: 'Luas lahan Tegal || isi 0 jika tidak ada',
                        inputHint: '(meter\u00B2)',
                        textInputType: TextInputType.number,
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      FormInputDesign(
                        controller: _luasPekaranganController,
                        label: 'Luas lahan Tegal || isi 0 jika tidak ada',
                        inputHint: '(meter\u00B2)',
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
                              padding: const EdgeInsets.only(left: 50.0, bottom: 8),
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
                          //
                          Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 5),
                              child : Container(
                                padding: EdgeInsets.symmetric(vertical: 27, horizontal: 25),
                                decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.grey[350]),
                                      bottom: BorderSide(color: Colors.grey[350]),
                                      left: BorderSide(color: Colors.grey[350]),
                                      right: BorderSide(color: Colors.grey[350])
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Pilih salah satu'),
                                    DropdownButton(
                                        hint: Text(bidangUsaha, overflow: TextOverflow.ellipsis,),
                                        items: <String>['Tanaman Pangan', 'Hortikultura', 'Biofarmaka', 'Perkebunan', 'Peternakan', 'Perikanan'].map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (_val){
                                              setState(() {
                                                bidangUsaha = _val;
                                              });
                                              switch(_val){
                                                case "Tanaman Pangan":
                                                  setState(() {
                                                    boolLainnya = false;
                                                    subBidangUsaha = tanamanPangan;
                                                    subBidangUsahaa = 'pilih salah satu';
                                                  });
                                                  break;

                                                case "Hortikultura":
                                                  setState(() {
                                                    boolLainnya = false;
                                                    subBidangUsaha = hortikultura;
                                                    subBidangUsahaa = 'pilih salah satu';
                                                  });
                                                  break;

                                                case "Biofarmaka":
                                                  setState(() {
                                                    boolLainnya = false;
                                                    subBidangUsaha = biofarmaka;
                                                    subBidangUsahaa = 'pilih salah satu';
                                                  });
                                                  break;

                                                case "Perkebunan":
                                                  setState(() {
                                                    boolLainnya = false;
                                                    subBidangUsaha = perkebunan;
                                                    subBidangUsahaa = 'pilih salah satu';
                                                  });
                                                  break;

                                                case "Peternakan":
                                                  setState(() {
                                                    boolLainnya = false;
                                                    subBidangUsaha = peternakan;
                                                    subBidangUsahaa = 'pilih salah satu';
                                                  });
                                                  break;

                                                case "Perikanan":
                                                  setState(() {
                                                    boolLainnya = false;
                                                    subBidangUsaha = perikanan;
                                                    subBidangUsahaa = 'pilih salah satu';
                                                  });
                                                  break;
                                          }
                                        }
                                    )
                                  ],
                                ),
                              )
                          ),
                          //
                        ],
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
                              padding: const EdgeInsets.only(left: 50.0, bottom: 8),
                              child: Text(
                                'Detail Bidang Usaha',
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
                              child : Container(
                                padding: EdgeInsets.symmetric(vertical: 27, horizontal: 25),
                                decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.grey[350]),
                                      bottom: BorderSide(color: Colors.grey[350]),
                                      left: BorderSide(color: Colors.grey[350]),
                                      right: BorderSide(color: Colors.grey[350])
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Pilih salah satu'),
                                    subBidangUsaha.isNotEmpty ? DropdownButton(
                                        hint: Text(subBidangUsahaa, overflow: TextOverflow.ellipsis,),
                                        items: subBidangUsaha.map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (_val){
                                          setState(() {
                                            subBidangUsahaa = _val;
                                          });
                                          if(_val == 'lainnya'){
                                            setState(() {
                                              boolLainnya = true;
                                            });
                                          }
                                        }
                                    ) : Text('')
                                  ],
                                ),
                              )
                          ),
                          //
                        ],
                      ),
                      //
                      SizedBox(
                        height: 20,
                      ),
                      boolLainnya ? Column(
                        children: <Widget>[
                      Column(
                      children: [
                        Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50.0, bottom: 8),
                          child: Text(
                            'Detail bidang usaha lainnya',
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
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              subBidangUsahaa = value;
                            });
                          },
                          style: TextStyle(
                              fontSize: 19,
                              color: Color(0xff0962ff),
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: 'Isikan Detail bidang usaha lainnya',
                            hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[350],
                                fontWeight: FontWeight.w600),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            focusColor: Color(0xff0962ff),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xff0962ff)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.grey[350],
                              ),
                            ),
                          ),
                        ),
                      ),
                      //
                    ],
                  ),
                          //
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ) : SizedBox(
                        height: 0,
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
                          await DakotaApi.createDakota(context,authProvider, _namacontroller.text,_namacontroller.text,alamatcontroller.text,_kecamatancontroller.text
                              ,_kelurahandesacontroller.text,latitude,longtitude,_namaketuacontroller.text, int.parse(_jumlahAnggotaLakiController.text), int.parse(_jumlahAnggotaPerempuanController.text), int.parse(_luasSawahController.text), int.parse(_luasTegalController.text), int.parse(_luasPekaranganController.text), bidangUsaha,subBidangUsahaa)
                              .then((value) {
                                if ( value == 200) {
                                  setState(() {
                                    notLoading = true;
                                  });
                              return showDialog(
                                context: context,
                                builder: (context){
                                  return DialogBox(
                                    title: 'Sukses',
                                    description: 'Selamat! data kelompok berhasil ditambahkan, silahkan tekan tombol konfirmasi untuk menuju halaman data kelompok tani',
                                    buttonText: 'konfirmasi',
                                    image: 'assets/success.gif',
                                    onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>DarkotaViewAll())),
                                  );
                                }
                              );} else {
                                  setState(() {
                                  notLoading = true;
                                });
                                  return showDialog(
                                      context: context,
                                      builder: (context){
                                        return DialogBox(
                                          title: 'Gagal',
                                          description: 'Terjadi kesalahan server. silahkan tekan tombol kembali',
                                          buttonText: 'kembali',
                                          image: 'assets/failed.gif',
                                        );
                                      }
                                  );
                              }});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: scrWidth * 0.85,
                          height: 75,
                          decoration: BoxDecoration(
                            color: Color(0xff0962ff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Simpan Data',
                              style: TextStyle(
                                fontFamily: 'ProductSans',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
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

  buildDropdownButton(String label, List<String> listItem, String inText) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, bottom: 8),
            child: Text(
              label,
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
          child : Container(
            padding: EdgeInsets.symmetric(vertical: 27, horizontal: 25),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[350]),
                bottom: BorderSide(color: Colors.grey[350]),
                left: BorderSide(color: Colors.grey[350]),
                right: BorderSide(color: Colors.grey[350])
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(inText),
                DropdownButton(
                    hint: Text(inText, overflow: TextOverflow.ellipsis,),
                    items: listItem.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_val){
                      switch('label'){
                        case 'Bidang usaha':
                          setState(() {
                            bidangUsaha = _val;
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
                          break;

                        case 'Detail bidang usaha':
                          setState(() {
                            subBidangUsahaa = _val;
                          });
                          if(_val == 'lainnya'){
                            setState(() {
                              boolLainnya = true;
                            });
                          }
                          break;

                      }
                    }
                )
              ],
            ),
          )
        ),
        //
      ],
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
