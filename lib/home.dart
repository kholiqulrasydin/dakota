import 'dart:math';

import 'package:dakota/Services/api/bantuan_usaha.dart';
import 'package:dakota/Services/api/dakota.dart';
import 'package:dakota/Services/auth.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/Services/providers/dakota.dart';
import 'package:dakota/animations/loader.dart';
import 'package:dakota/dakota_add.dart';
import 'package:dakota/dakota_viewAll.dart';
import 'package:dakota/edit_profile_page.dart';
import 'package:dakota/model/DakotaModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Dashboard/categories_row.dart';
import 'Dashboard/pie_chart.dart';
import 'Dashboard/pie_chart_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _drawerKey = GlobalKey<ScaffoldState>();

  List<DakotaModel> dData = [];
  List<Category> keyCategory =[];

  void refreshLatest(BantuanUsaha bantuanUsaha, DakotaProvider dakotaProvider) async {
    await DakotaApi.getLast(dakotaProvider);
    await BantuanUsahaApi.getCountData(bantuanUsaha);
  }

  void setData(DakotaProvider dakotaProvider, BantuanUsaha bantuanUsaha) async {
    setState(() {
      dData = dakotaProvider.dakotaList;
    });
    bantuanUsaha.jData = keyCategory;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onRefresh();
  }
  Future<void> _onRefresh() async {
    BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context, listen: false);
    DakotaProvider dakotaProvider = Provider.of<DakotaProvider>(context, listen: false);

    refreshLatest(bantuanUsaha, dakotaProvider);
    return setData(dakotaProvider, bantuanUsaha);

    }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

//    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    DakotaProvider dakotaProvider = Provider.of<DakotaProvider>(context);
    BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context);

    refreshLatest(bantuanUsaha, dakotaProvider);

    return Consumer<BantuanUsaha>(
      builder: (_, bantuanUsaha, __){
        return Loader(
          inAsyncCall: bantuanUsaha.jData.isEmpty,
          child: Scaffold(
            backgroundColor: Colors.white,
            key: _drawerKey,
            drawer: Drawer(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin:
                          EdgeInsets.only(top: height * 0.04, left: width * 0.02),
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
//                              await BantuanUsahaApi.getCountData(authProvider, bantuanUsaha);
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => EditProfilePage()));
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: height * 0.04,
                              left: width * 0.26,
                              right: width * 0.02),
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
                      margin:
                      EdgeInsets.only(top: height * 0.05, bottom: height * 0.03),
                      padding: EdgeInsets.all(width * 0.17),
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
                        width: width * 0.60,
                        margin: EdgeInsets.only(bottom: height * 0.03),
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
                        width: width * 0.60,
                        margin: EdgeInsets.only(bottom: height * 0.03),
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
                        width: width * 1,
                        padding:
                        EdgeInsets.only(left: width * 0.08, top: height * 0.02),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Jumlah Bantuan',
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                      ),
                      Consumer<BantuanUsaha>(
                        builder: (_, bantuanUsaha, __) {
                          return Container(
                            width: width * 0.90,
                            height: height * 0.30,
                            child:  Row(
                              children: <Widget>[
                                CategoriesRow(),
                                PieChartView(),
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: width * 0.08),
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
                        height: height * 0.27,
                        child: LastAdded(dData),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return SafeArea(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          itemCount: dData.length,
          itemBuilder: (context, index) {
            var c = random.nextInt(colors.length);
            final _data = dData[index];
            return HorizontalCardItem(categoryHeight: categoryHeight, colors: colors, c: c, authProvider: authProvider, dakotaProvider: dakotaProvider, data: _data, bantuanUsaha: bantuanUsaha);
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
      margin: EdgeInsets.symmetric(vertical: 35, horizontal: 10),
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
                    fontSize: 25,
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
