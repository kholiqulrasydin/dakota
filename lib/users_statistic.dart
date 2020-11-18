import 'dart:math';

import 'package:dakota/Dashboard/categories_row.dart';
import 'package:dakota/Dashboard/pie_chart.dart';
import 'package:dakota/Dashboard/pie_chart_view.dart';
import 'package:dakota/Services/api/bantuan_usaha.dart';
import 'package:dakota/Services/api/dakota.dart';
import 'package:dakota/Services/api/user.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/Services/providers/dakota.dart';
import 'package:dakota/Services/providers/user.dart';
import 'package:dakota/animations/loader.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/home.dart';
import 'package:dakota/model/DakotaModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserStatistic extends StatefulWidget {
  @override
  _UserStatisticState createState() => _UserStatisticState();
}

class _UserStatisticState extends State<UserStatistic> {

  List<Category> bData = [];
  List<DakotaModel> dData = [];
  void _onInit() async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context, listen: false);
    DakotaProvider dakotaProvider = Provider.of<DakotaProvider>(context, listen: false);
    bantuanUsaha.jData = bData;
    dakotaProvider.dakotaListLatest = dData;
    await DakotaApi.getLastByUser(dakotaProvider);
    await UserApi.userFetch(userProvider);
    await BantuanUsahaApi.getCountDatabyUser(bantuanUsaha);
  }

  Future<void> _onRefresh() async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context, listen: false);
    DakotaProvider dakotaProvider = Provider.of<DakotaProvider>(context, listen: false);
    bantuanUsaha.jData = bData;
    dakotaProvider.dakotaListLatest = dData;
    await DakotaApi.getLastByUser(dakotaProvider);
    await UserApi.userFetch(userProvider);
    await BantuanUsahaApi.getCountDatabyUser(bantuanUsaha);
  }

  @override
  void initState() {
    _onInit();
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<DakotaProvider>(builder: (_, dakotaProvider, __){
      return Consumer<UserProvider>(
          builder: (context, userProvider, _u){
            return Consumer<BantuanUsaha>(
                builder: (_, bantuanUsaha, __){
                  return Loader(
                    inAsyncCall: bantuanUsaha.jData.isEmpty && dakotaProvider.dakotaListLatest.isEmpty,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                            }),
                        title: Text('Statistik Anda', style: TextStyle(color: Colors.blueGrey),),
                      ),
                      body: RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: SizeConfig.widthMultiplier * 100,
                                padding:
                                EdgeInsets.only(left: SizeConfig.widthMultiplier * 8, top: SizeConfig.widthMultiplier * 2),
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Jumlah Bantuan Yang Anda Tambahkan',
                                  style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w400, fontSize: 18),
                                ),
                              ),
                              Container(
                                width: SizeConfig.widthMultiplier * 90,
                                height: SizeConfig.heightMultiplier * 40,
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    PieChartView(jData: bantuanUsaha.jData),
                                    CategoriesRow(),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 8),
                                child: Text(
                                  'Semua Data Kelompok\nyang ditambahkan oleh anda',
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
                }
            );
          }
      );
    });
  }
}

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
