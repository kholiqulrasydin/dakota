import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/home.dart';
import 'package:dakota/user_list.dart';
import 'package:flutter/material.dart';

import 'dakota_viewAll.dart';

class RuangAdmin extends StatefulWidget {
  @override
  _RuangAdminState createState() => _RuangAdminState();
}

class _RuangAdminState extends State<RuangAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Ruang Admin',
          style: TextStyle(color: Colors.blueGrey),
        ),leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueGrey,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
          }),
      ),
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.widthMultiplier * 10),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: <Widget>[
              BuildFeaturesCard(
                assetImage: 'assets/user.png', onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserListView()));
              }, title: 'Data User'),
              BuildFeaturesCard(
                assetImage: 'assets/gallery.png', onTap: () {
              }, title: 'Data Kegiatan'),
              BuildFeaturesCard(
              assetImage: 'assets/kelompok.jpeg', onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DarkotaViewAll()));
                }, title: 'Data Kelompok')
        ],
      ),
          )),
    );
  }
}
