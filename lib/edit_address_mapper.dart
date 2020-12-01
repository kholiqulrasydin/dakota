import 'dart:async';

import 'package:dakota/Services/providers/dakota.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/dakota_edit.dart';
import 'package:dakota/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class EditAddressMapper extends StatefulWidget {
  final String namaKelompok;
  final String namaKetua;
  final String alamat;
  final String kelurahan;
  final String kecamatan;
  final String jumlahAnggotalaki;
  final String jumlahAnggotaPerempuan;
  final String bidangUsaha;
  final String subBidangUsaha;
  final String luasSawah;
  final String luasTegal;
  final String luasPekarangan;
  final String id;

  const EditAddressMapper({Key key, this.namaKelompok ='n', this.namaKetua ='n', this.alamat ='n', this.kelurahan ='n', this.kecamatan ='n', this.jumlahAnggotalaki ='n', this.jumlahAnggotaPerempuan ='n', this.luasSawah ='n', this.luasPekarangan ='n', this.luasTegal ='n', this.bidangUsaha ='n', this.subBidangUsaha, @required this.id});

  @override
  _EditAddressMapperState createState() => _EditAddressMapperState();
}

class _EditAddressMapperState extends State<EditAddressMapper> {
  String latitude, longtitude;
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;
//  int _markerIdCounter = 0;
  DakotaProvider dakotaProvider;
//  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  GoogleMapController mapController;
  Location location = new Location();
//  StreamSubscription locationSubscription;

//  String _markerIdVal({bool increment = false}) {
//    String val = 'marker_id_$_markerIdCounter';
//    if (increment) _markerIdCounter++;
//    return val;
//  }

  bool itsOkay = false;

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  Future<void> _pilihLokasiSaya() async {
    final GoogleMapController mapController = await _controller.future;
    location.getLocation().then((l){
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 18)),
      );
      _handleTap(LatLng(l.latitude, l.longitude));
    });
  }

  List<Marker> myMarker = [];

//  @override
//  void dispose() {
//    if (locationSubscription != null) {
//      locationSubscription.cancel();
//    }
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pilih Lokasi Anda',
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            _controller.isCompleted;
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueGrey,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(-7.8757537, 111.4518134), zoom: 11.0),
            onMapCreated: _onMapCreated,
            onTap: _handleTap,
            mapType: _currentMapType,
            markers: Set.from(myMarker),
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            zoomControlsEnabled: false,
//            onCameraMove: (CameraPosition position) {
//              if (myMarker.length > 0) {
//                MarkerId markerId = MarkerId(_markerIdVal());
//                Marker marker = _markers[markerId];
//                Marker updatedMarker = marker.copyWith(
//                  positionParam: position.target,
//                );
//                setState(() {
//                  _markers[markerId] = updatedMarker;
//                });
//              }
//            },
          ),
          Container(
            padding: EdgeInsets.only(
                left: SizeConfig.widthMultiplier * 20,
                right: SizeConfig.widthMultiplier * 20),
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 13),
            child: (itsOkay)
                ? RoundedButton(
              color: Colors.blueGrey,
              text: "Simpan Lokasi",
              press: () {
                _controller.isCompleted;
                Navigator.push(context, MaterialPageRoute(builder: (context) => DakotaEditingForm(namaKelompok: widget.namaKelompok, namaKetua: widget.namaKetua, alamat: widget.alamat, kelurahan: widget.kelurahan, kecamatan: widget.kecamatan, jumlahAnggotalaki: widget.jumlahAnggotalaki, jumlahAnggotaPerempuan: widget.jumlahAnggotaPerempuan, luasSawah: widget.luasSawah, luasPekarangan: widget.luasPekarangan, luasTegal: widget.luasTegal, latitude: latitude, longtitude: longtitude, bidangUsaha: widget.bidangUsaha, subBidangUsaha: widget.subBidangUsaha, id: widget.id,)));
              },
            )
                : Container(
              child: Text(''),
              decoration: BoxDecoration(color: Colors.transparent),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{ await _pilihLokasiSaya();},
        child: Icon(Icons.my_location, color: Colors.white,),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }

  _handleTap(LatLng point)  {
//    dakotaProvider.resetAll();
//    dakotaProvider.changeGeo(String(point.latitude, point.longitude));
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
      latitude = point.latitude.toString();
      longtitude = point.longitude.toString();
      itsOkay = true;
    });
  }
}
