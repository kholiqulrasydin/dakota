import 'dart:async';

import 'package:dakota/Services/providers/dakota.dart';
import 'package:dakota/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'animations/sizeconfig.dart';

class AddAddressMapper extends StatefulWidget {
  @override
  _AddAddressMapperState createState() => _AddAddressMapperState();
}

class _AddAddressMapperState extends State<AddAddressMapper> {
  String latitude,longtitude;
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;
  int _markerIdCounter = 0;
  DakotaProvider dakotaProvider;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  bool itsOkay = false;


  _onMapCreated(GoogleMapController googleMapController){
    _controller.complete(googleMapController);
  }

  List<Marker> myMarker=[];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Pilih Lokasi Anda'),),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(-7.8757537, 111.4518134), zoom: 11.0),
            onMapCreated: _onMapCreated,
            onTap: _handleTap,
            mapType: _currentMapType,
            markers: Set.from(myMarker),
            myLocationButtonEnabled: true,
            onCameraMove: (CameraPosition position) {
              if(myMarker.length > 0) {
                MarkerId markerId = MarkerId(_markerIdVal());
                Marker marker = _markers[markerId];
                Marker updatedMarker = marker.copyWith(
                  positionParam: position.target,
                );
                setState(() {
                  _markers[markerId] = updatedMarker;
                });
              }
            },
          ),
          Container(
            padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 20, right:  SizeConfig.widthMultiplier * 20),
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 13),
            child: (itsOkay) ? RoundedButton(
              text: "Simpan Lokasi",
              press: () {
                Navigator.of(context).pop();
              },
            ) : Container(child: Text(''), decoration: BoxDecoration(color: Colors.transparent),),
          ),
        ],
      ),
    );
  }
  _handleTap(LatLng point) {
//    dakotaProvider.resetAll();
//    dakotaProvider.changeGeo(String(point.latitude, point.longitude));
    setState(() {
      myMarker=[];
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
