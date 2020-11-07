import 'package:dakota/dakota_add.dart';
import 'package:dakota/dakota_viewAll.dart';
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
              Container(
                margin: EdgeInsets.only(top: height * 0.04, left: width * 0.50, right: width * 0.02),
                alignment: Alignment.topRight,
                child: Row(
                  children: <Widget>[
                    Text('Logout ', style: TextStyle(color: Colors.blueGrey), textAlign: TextAlign.right,),
                    IconButton(icon: Icon(Icons.launch), onPressed: (){}),
                  ],
                ),
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
              InkWell(
                onTap: (){},
                child: Container(
                  width: width * 0.60,
                  margin: EdgeInsets.only(bottom: height * 0.03),
                  child: Column(
                    children: <Widget>[
                      Text('Kelompok Tani Berdasar Kecamatan', style: TextStyle(color: Colors.blueGrey),),
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
      body: Container(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
