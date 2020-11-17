import 'dart:math';

import 'package:dakota/Dashboard/pie_chart.dart';
import 'package:dakota/Services/api/bantuan_usaha.dart';
import 'package:dakota/Services/api/dakota.dart';
import 'package:dakota/Services/auth.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/Services/providers/dakota.dart';
import 'package:dakota/animations/loader.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/dakota_add.dart';
import 'package:dakota/dakota_viewAll.dart';
import 'package:dakota/edit_profile_page.dart';
import 'package:dakota/model/DakotaModel.dart';
import 'package:dakota/users_statistic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Dashboard/categories_row.dart';
import 'Dashboard/pie_chart_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _drawerKey = GlobalKey<ScaffoldState>();

  List<DakotaModel> dData = [];
  List<Category> keyCategory =[];

  void setData(DakotaProvider dakotaProvider) async {

    setState(() {
      dData = dakotaProvider.dakotaListLatest;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context, listen: false);
//    DakotaProvider dakotaProvider = Provider.of<DakotaProvider>(context, listen: false);
//    refreshLatest(bantuanUsaha, dakotaProvider);
//    setData(dakotaProvider, bantuanUsaha);
  refreshNow();
  }
  void refreshNow() async {
    BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context, listen: false);
    DakotaProvider dakotaProvider = Provider.of<DakotaProvider>(context, listen: false);

    bantuanUsaha.jData = keyCategory;
    await DakotaApi.getLast(dakotaProvider);
    await BantuanUsahaApi.getCountData(bantuanUsaha);
    setData(dakotaProvider);
  }


  Future<void> _onRefresh() async {
    return refreshNow();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    DakotaProvider dakotaProvider = Provider.of<DakotaProvider>(context);
//    BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context);
//    setData(dakotaProvider, bantuanUsaha);

    return Consumer<BantuanUsaha>(
      builder: (_, bantuanUsaha, __){
        return Loader(
          inAsyncCall: bantuanUsaha.jData.isEmpty,
          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                SizeConfig().init(constraints, orientation);
                return Scaffold(
                  backgroundColor: Colors.white,
                  key: _drawerKey,
                  drawer: Drawer(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin:
                                EdgeInsets.only(top: SizeConfig.heightMultiplier * 4, left: SizeConfig.widthMultiplier * 2),
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: <Widget>[
                              Text(
                                'Profil ',
                                style: TextStyle(color: Colors.blueGrey),
                                textAlign: TextAlign.right,
                              ),
                              IconButton(
                                  icon: Icon(Icons.person),
                                  onPressed: () async {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => EditProfilePage()));
                                  }),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: SizeConfig.heightMultiplier * 4,
//                                    left: SizeConfig.widthMultiplier * 47,
//                                    right: SizeConfig.widthMultiplier * 2
                                    ),
                                alignment: Alignment.topRight,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Logout ',
                                      style: TextStyle(color: Colors.blueGrey),
                                      textAlign: TextAlign.right,
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.launch),
                                        onPressed: () async {
                                          await AuthServices.signOut(context);
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: SizeConfig.imageSizeMultiplier * 50,
                            height: SizeConfig.imageSizeMultiplier * 60,
                            margin: EdgeInsets.only(top: SizeConfig.heightMultiplier * 5, bottom: SizeConfig.heightMultiplier * 3),
                            padding: EdgeInsets.all(SizeConfig.widthMultiplier * 10),
                            child: Image.asset('assets/Lambang_Kabupaten_Ponorogo.png'),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DakotaAdd()),
                              );
                            },
                            child: Container(
                              width: SizeConfig.widthMultiplier * 70,
                              margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 3),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Tambah Data',
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                  Divider(
                                    color: Colors.blueGrey,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DarkotaViewAll()),
                              );
                            },
                            child: Container(
                              width: SizeConfig.widthMultiplier * 70,
                              margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 3),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Lihat Semua Data Kelompok Tani',
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                  Divider(
                                    color: Colors.blueGrey,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UserStatistic()),
                              );
                            },
                            child: Container(
                              width: SizeConfig.widthMultiplier * 70,
                              margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 3),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Statistik Anda',
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                  Divider(
                                    color: Colors.blueGrey,
                                  )
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
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: SizeConfig.widthMultiplier * 100,
                              padding:
                              EdgeInsets.only(left: SizeConfig.widthMultiplier * 8, top: SizeConfig.widthMultiplier * 2),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Jumlah Bantuan',
                                style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.w400, fontSize: 18),
                              ),
                            ),
                                Container(
                                  width: SizeConfig.widthMultiplier * 90,
                                  height: SizeConfig.heightMultiplier * 40,
                                  child:  Row(
                                    children: <Widget>[
                                      CategoriesRow(),
                                      PieChartView(jData: bantuanUsaha.jData),
                                    ],
                                  ),
                                ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 8),
                              child: Text(
                                'Terakhir ditambahkan',
                                style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.w400, fontSize: 18),
                              ),
                            ),
                             AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: width,
                                  alignment: Alignment.topCenter,
                                  height: SizeConfig.heightMultiplier * 27,
                                  child: LastAdded(dakotaProvider.dakotaListLatest),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },

            );
            },
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class LastAdded extends StatelessWidget {
  final List<DakotaModel> dData;
  LastAdded(this.dData);

  var colors = [
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
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    DakotaProvider dakotaProvider = Provider.of<DakotaProvider>(context);
    BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context);
    final double categoryHeight = SizeConfig.heightMultiplier * 80;
    return SafeArea(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          itemCount: dData.length,
          itemBuilder: (context, index) {
//            var c = random.nextInt(colors.length);
            final _data = dData[index];
            return HorizontalCardItem(categoryHeight: categoryHeight, colors: colors, c: index, authProvider: authProvider, dakotaProvider: dakotaProvider, data: _data, bantuanUsaha: bantuanUsaha);
          }),
    );
  }
}

class HorizontalCardItem extends StatelessWidget {
  const HorizontalCardItem({
    Key key,
    @required this.categoryHeight,
    @required this.colors,
    @required this.c,
    @required this.authProvider,
    @required this.dakotaProvider,
    @required DakotaModel data,
    @required this.bantuanUsaha,
  }) : _data = data, super(key: key);

  final double categoryHeight;
  final List<Color> colors;
  final int c;
  final AuthProvider authProvider;
  final DakotaProvider dakotaProvider;
  final DakotaModel _data;
  final BantuanUsaha bantuanUsaha;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      height: categoryHeight,
      decoration: BoxDecoration(
          color: colors[c],
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: InkWell(
        onTap: () async {
          await DakotaApi.getPersonalGroup(context, dakotaProvider, _data.id, bantuanUsaha);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _data.namaKelompok,
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 3.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _data.kelurahan,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
