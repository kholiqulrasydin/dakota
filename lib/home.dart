
import 'package:dakota/Services/auth.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/dakota_add.dart';
import 'package:dakota/dakota_viewAll.dart';
import 'package:dakota/edit_profile_page.dart';
import 'package:dakota/users_statistic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _drawerKey = GlobalKey<ScaffoldState>();

  final List<String> _listItem = [
    'assets/farmer.png',
    'assets/statistics.png',
    'assets/total-comander.png',
    'assets/gallery.png',
    'assets/admin.png',
    'assets/user.png',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            SizeConfig().init(constraints, orientation);
            return Scaffold(
              key: _drawerKey,
              backgroundColor: Colors.white,
              drawer: new Drawer(
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
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      _drawerKey.currentState.openDrawer();
                    }),
                title: Text(
                  'Beranda',
                  style: TextStyle(color: Colors.blueAccent),
                ),
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.search, color: Colors.blueAccent,), onPressed: () {  },)
                ],
              ),
              body: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage('assets/kontjotanie.jpg'),
                                  fit: BoxFit.cover
                              )
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    colors: [
                                      Colors.blue[900].withOpacity(.4),
                                      Colors.blue[900].withOpacity(.2),
                                    ]
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text("kegiatan kami", style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),),
                                SizedBox(height: 30,),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                  ),
                                  child: Center(child: Text("Lihat Lainnya", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),)),
                                ),
                                SizedBox(height: 30,),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: [
                            BuildFeaturesCard(
                              title: 'Data Kelompok',
                              assetImage: _listItem[0],
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>DarkotaViewAll()));
                              },
                            ),
                            BuildFeaturesCard(
                              title: 'Visualisasi Data',
                              assetImage: _listItem[1],
                              onTap: (){

                              },
                            ),
                            BuildFeaturesCard(
                              title: 'Rekapitulasi',
                              assetImage: _listItem[2],
                              onTap: (){

                              },
                            ),
                            BuildFeaturesCard(
                              title: 'Gallery Kegiatan',
                              assetImage: _listItem[3],
                              onTap: (){

                              },
                            ),
                            BuildFeaturesCard(
                              title: 'Ruang Admin',
                              assetImage: _listItem[4],
                              onTap: (){

                              },
                            ),
                            BuildFeaturesCard(
                              title: 'Statistik Anda',
                              assetImage: _listItem[5],
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UserStatistic()));
                              },
                            ),
                          ],
                        )
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

class BuildFeaturesCard extends StatelessWidget {
  const BuildFeaturesCard({
    Key key, @required this.assetImage, @required this.onTap, @required this.title
  }) : super(key: key);

  final String assetImage, title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.blueAccent.withAlpha(100), blurRadius: 10.0),
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: AssetImage(assetImage),
                        fit: BoxFit.contain
                    )
                ),
                child: Transform.translate(
                  offset: Offset(50, -50),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
//                        color: Colors.white
                    ),
                    child: Text(''),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(title, style: TextStyle(color: Colors.blueGrey),)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
