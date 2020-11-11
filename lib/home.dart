import 'dart:math';

import 'package:dakota/dakota_add.dart';
import 'package:dakota/dakota_view.dart';
import 'package:dakota/dakota_viewAll.dart';
import 'package:dakota/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Dashboard/categories_row.dart';
import 'Dashboard/pie_chart_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _drawerKey = GlobalKey<ScaffoldState>();

  final fData = [
    {
      "name": "Konco Tani",
      "ketuaKelompok": "Sutejo",
      "kelurahan": "Nambangrejo",
      "image": "kontjotanie.jpg"
    },
    {
      "name": "Tani Makmur",
      "ketuaKelompok": "Bowo",
      "kelurahan": "Bangunsari",
      "image": "kontjotanie.jpg"
    },
    {
      "name": "Subur Jaya",
      "ketuaKelompok": "Suyatno",
      "kelurahan": "Mirah",
      "image": "kontjotanie.jpg"
    },
    {
      "name": "Tani Makmur",
      "ketuaKelompok": "Bambang",
      "kelurahan": "Sukorejo",
      "image": "kontjotanie.jpg"
    },
    {
      "name": "Tani Subur",
      "ketuaKelompok": "Rahmadi",
      "kelurahan": "Ponorogo",
      "image": "kontjotanie.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return new Scaffold(
      backgroundColor: Colors.white,
      key: _drawerKey,
      drawer: Drawer(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: height * 0.04, left: width * 0.02),
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: <Widget>[
                        Text('Profil ', style: TextStyle(color: Colors.blueGrey), textAlign: TextAlign.right,),
                        IconButton(icon: Icon(Icons.person), onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfilePage()));
                        }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * 0.04, left: width * 0.26, right: width * 0.02),
                    alignment: Alignment.topRight,
                    child: Row(
                      children: <Widget>[
                        Text('Logout ', style: TextStyle(color: Colors.blueGrey), textAlign: TextAlign.right,),
                        IconButton(icon: Icon(Icons.launch), onPressed: (){}),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.03),
                padding: EdgeInsets.all(width * 0.17),
                child: Image.asset('assets/Lambang_Kabupaten_Ponorogo.png'),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DakotaAdd()),
                  );
                },
                child: Container(
                  width: width * 0.60,
                  margin: EdgeInsets.only(bottom: height * 0.03),
                  child: Column(
                    children: <Widget>[
                      Text('Tambah Data', style: TextStyle(color: Colors.blueGrey),),
                      Divider(color: Colors.blueGrey,)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DarkotaViewAll()),
                  );
                },
                child: Container(
                  width: width * 0.60,
                  margin: EdgeInsets.only(bottom: height * 0.03),
                  child: Column(
                    children: <Widget>[
                      Text('Lihat Semua Data Kelompok Tani', style: TextStyle(color: Colors.blueGrey),),
                      Divider(color: Colors.blueGrey,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.blueGrey,
            ),
            onPressed: () {
              _drawerKey.currentState.openDrawer();
            }),
        backgroundColor: Colors.white,
        title: Text(
          'Data Kelompok Tani',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: width * 1,
                        padding: EdgeInsets.only(left: width * 0.08, top: height * 0.02),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Jumlah Bantuan',
                          style:
                          GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                      ),
                      Container(
                        width: width * 0.90,
                        height: height * 0.30,
                        child: Expanded(
                          child: Row(
                            children: <Widget>[
                              CategoriesRow(),
                              PieChartView(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: width * 0.08),
                        child: Text('Terakhir ditambahkan', style:
                        GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: 18),),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: width,
                        alignment: Alignment.topCenter,
                        height: height * 0.27,
                        child: LastAdded(fData),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class LastAdded extends StatelessWidget {
  List fData;
  LastAdded(this.fData);

  var colors =[
    Colors.teal.shade400,
    Colors.blue.shade400,
    Colors.deepPurpleAccent.shade400,
    Colors.blueGrey.shade400,
    Colors.amber.shade400,
    Colors.pinkAccent.shade400,
    Colors.teal.shade400,
    Colors.blue.shade400,
    Colors.deepPurpleAccent.shade400,
    Colors.blueGrey.shade400,
    Colors.amber.shade400,
  ];
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return SafeArea(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: fData.length,
          itemBuilder: (context, index){
            var c = random.nextInt(
                colors.length);
            final _data = fData[index];
            return Container(
                width: 150,
                margin: EdgeInsets.symmetric(vertical: 35, horizontal: 10),
                height: categoryHeight,
                decoration: BoxDecoration(
                    color: colors[c],
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DakotaView(_data['name'])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _data['name'],
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _data['kelurahan'],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
            );
          }
      ),
    );
  }
}

