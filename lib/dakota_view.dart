import 'package:dakota/Services/api/bantuan_usaha.dart';
import 'package:dakota/Services/api/dakota.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/Services/providers/dakota.dart';
import 'package:dakota/Services/providers/user.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/bantuan_create.dart';
import 'package:dakota/dakota_edit.dart';
import 'package:dakota/dakota_viewAll.dart';
import 'package:dakota/model/BantuanUsahaModel.dart';
import 'package:dakota/model/DakotaModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DakotaView extends StatefulWidget {
  final int id;
  final List<DakotaModel> _dakota;
  final List<BantuanUsahaModel> _bantuanUsaha;

  DakotaView(this.id, this._dakota, this._bantuanUsaha);

  @override
  _DakotaViewState createState() => _DakotaViewState();
}

class _DakotaViewState extends State<DakotaView> {
  final GlobalKey<ScaffoldState> _viewKey = new GlobalKey<ScaffoldState>();
  List<Marker> myMarker = [];
  GoogleMapController mapController;
  MapType _currentMapType = MapType.normal;

  _onMapCreated(GoogleMapController googleMapController) async {
      LatLng point = LatLng(double.parse(widget._dakota.first.geoLatitude), double.parse(widget._dakota.first.geoLongtitude));
      setState(() {
        myMarker = [];
        myMarker.add(Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          infoWindow: InfoWindow(
            title: point.toString(),
          ),
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        ));
      });
  }


  @override
  Widget build(BuildContext context) {
//    int totalJumlahAnggota = widget._dakota.first.jumlahLaki + widget._dakota.first.jumlahPerempuan;
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DarkotaViewAll()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueAccent,
          ),
        ),
        title: Text(
          'Profil Kelompok',
          style: TextStyle(color: Colors.blueGrey),
        ),
        actions: <Widget>[
          (userProvider.personalUser.first.privileges == 1) ? DakotaDelete(widget: widget, viewKey: _viewKey,) : Text(''),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Text(
              "${widget._dakota.first.namaKelompok}",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Informasi Kelompok",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                (userProvider.personalUser.first.privileges == 1) ? IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    print(widget._dakota.first.id.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DakotaEditingForm(namaKelompok: widget._dakota.first.namaKelompok, namaKetua: widget._dakota.first.namaKetua, alamat: widget._dakota.first.alamat, kelurahan: widget._dakota.first.kelurahan, kecamatan: widget._dakota.first.kecamatan, jumlahAnggotalaki: widget._dakota.first.jumlahLaki.toString(), jumlahAnggotaPerempuan: widget._dakota.first.jumlahPerempuan.toString(), luasSawah: widget._dakota.first.luasSawah.toString(), luasPekarangan: widget._dakota.first.luasPekarangan.toString(), luasTegal: widget._dakota.first.luasTegal.toString(), latitude: widget._dakota.first.geoLatitude, longtitude: widget._dakota.first.geoLongtitude, bidangUsaha: widget._dakota.first.bidangUsaha, subBidangUsaha: widget._dakota.first.subBidangUsaha, id: widget._dakota.first.id.toString(),)));
                  },
                ) : Text(''),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(
                context, "Nama Kelompok", widget._dakota.first.namaKelompok),
            buildAccountOptionRow(
                context, "Nomor Register", widget._dakota.first.nomorRegister),
            buildAccountOptionRow(
                context, "Alamat", widget._dakota.first.alamat),
            buildAccountOptionRow(
                context, "Kecamatan", widget._dakota.first.kecamatan),
            buildAccountOptionRow(
                context, "Kelurahan/Desa", widget._dakota.first.kelurahan),
            buildAccountOptionRow(
                context, "Nama Ketua", widget._dakota.first.namaKetua),
            buildAccountOptionRow(context, "Jumlah Anggota Laki-Laki",
                '${widget._dakota.first.jumlahLaki.toString()} orang'),
            buildAccountOptionRow(context, "Jumlah Anggota Perempuan",
                '${widget._dakota.first.jumlahPerempuan.toString()} orang'),
            buildAccountOptionRow(context, "Total Anggota", widget._dakota.first.jumlahLaki == null && widget._dakota.first.jumlahPerempuan == null ? '0 orang' : '${(widget._dakota.first.jumlahPerempuan + widget._dakota.first.jumlahLaki).toString()} orang'),
            buildAccountOptionRow(
                context, "Luas Lahan Sawah", '${widget._dakota.first.luasSawah.toString()} meter\u00B2'),
            buildAccountOptionRow(
                context, "Luas Lahan Pekarangan", '${widget._dakota.first.luasPekarangan.toString()} meter\u00B2'),
            buildAccountOptionRow(
                context, "Luas Lahan Tegal", '${widget._dakota.first.luasTegal.toString()} meter\u00B2'),
            buildAccountOptionRow(
                context, "Total Luas Lahan ", widget._dakota.first.luasSawah == null && widget._dakota.first.luasPekarangan == null && widget._dakota.first.luasTegal == null ? '0 meter' : '${(widget._dakota.first.luasPekarangan + widget._dakota.first.luasSawah + widget._dakota.first.luasTegal).toString()} meter\u00B2'),
            buildAccountOptionRow(
                context, "Bidang Usaha", widget._dakota.first.bidangUsaha),
            SizedBox(height: SizeConfig.heightMultiplier * 2,),
            buildAccountOptionRow(context, "Lokasi Alamat", ''),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              height: SizeConfig.heightMultiplier * 20,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(widget._dakota.first.geoLatitude), double.parse(widget._dakota.first.geoLongtitude)), zoom: 15.0),
                onMapCreated: _onMapCreated,
                mapType: _currentMapType,
                markers: Set.from(myMarker),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      Icons.accessibility,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Bantuan",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      print(widget.id.toString());
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BantuanCreate(widget.id)));
                    })
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget._bantuanUsaha.length,
                    itemBuilder: (context, index) {
                      final _data = widget._bantuanUsaha[index];
                      return buildDonation(context, "Bantuan ${_data.nama}",
                          _data.id, widget._bantuanUsaha.first, userProvider);
                    })),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildDonation(
      BuildContext context, String title, int id, BantuanUsahaModel bantuan, UserProvider userProvider) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Jenis Bantuan : "),
                        Text(bantuan.nama),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Detail : "),
                        Flexible(child: Text(bantuan.detail, overflow: TextOverflow.clip, textAlign: TextAlign.end,)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("status : "),
                        Text(bantuan.status),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("jumlah : "),
                        Text("${bantuan.jumlah} paket"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("tahun : "),
                        Text(bantuan.tahun),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Keterangan : "),
                        Text(bantuan.keterangan),
                      ],
                    ),
                  ],
                ),
                actions: [
                  (userProvider.personalUser.first.privileges == 1) ? InkWell(
                    onTap: () async {
                      BantuanUsaha bantuanUsaha =
                          Provider.of<BantuanUsaha>(context, listen: false);
                      DakotaProvider dakotaProvider =
                          Provider.of<DakotaProvider>(context, listen: false);
                      await BantuanUsahaApi.deleteBantuan(
                          context, dakotaProvider, bantuanUsaha, bantuan.id);
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Hapus',
                          style: TextStyle(color: Colors.redAccent.shade400),
                        ),
                        Icon(
                          Icons.delete,
                          color: Colors.redAccent.shade400,
                        ),
                      ],
                    ),
                  ) : Text(''),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Tutup")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAccountOptionRow(
      BuildContext context, String title, String detail) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.start,
              ),
              Text('')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                detail,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),
              ),
              Text('')
            ],
          ),
        ],
      ),
    );
  }
}

class DakotaDelete extends StatelessWidget {
  const DakotaDelete({
    Key key,
    @required this.widget, @required this.viewKey
  }) : super(key: key);

  final DakotaView widget;
  final GlobalKey<ScaffoldState> viewKey;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text('Hapus Data'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Apakah anda yakin ingin menghapus data ini?'),
                      FlatButton(
                          onPressed: () async {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DarkotaViewAll()));
                            await DakotaApi.deleteDakota(context, viewKey, widget.id);
                          },
                          child: Text(
                            "Iya Hapus!",
                            style: TextStyle(
                                color: Colors.redAccent.shade400),
                          )),
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Tidak")),
                    ],
                  ));
            });
      },
      icon: Icon(
        Icons.delete,
        color: Colors.redAccent.shade400,
      ),
    );
  }
}
