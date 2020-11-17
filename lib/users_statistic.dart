import 'package:dakota/Dashboard/categories_row.dart';
import 'package:dakota/Dashboard/pie_chart.dart';
import 'package:dakota/Dashboard/pie_chart_view.dart';
import 'package:dakota/Services/api/bantuan_usaha.dart';
import 'package:dakota/Services/api/user.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/Services/providers/user.dart';
import 'package:dakota/animations/loader.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserStatistic extends StatefulWidget {
  @override
  _UserStatisticState createState() => _UserStatisticState();
}

class _UserStatisticState extends State<UserStatistic> {

  List<Category> bData = [];
  void _onInit() async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context, listen: false);
    bantuanUsaha.jData = bData;
    await UserApi.userFetch(userProvider);
    await BantuanUsahaApi.getCountDatabyUser(bantuanUsaha);
  }

  Future<void> _onRefresh() async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context, listen: false);
    bantuanUsaha.jData = bData;
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
    return Consumer<UserProvider>(
      builder: (context, userProvider, _u){
        return Consumer<BantuanUsaha>(
          builder: (_, bantuanUsaha, __){
            return Loader(
              inAsyncCall: bantuanUsaha.jData.isEmpty,
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
  }
}
