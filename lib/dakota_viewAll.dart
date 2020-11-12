import 'package:dakota/Services/api/dakota.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/Services/providers/dakota.dart';
import 'package:dakota/model/DakotaModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkotaViewAll extends StatefulWidget {
  @override
  _DarkotaViewAllState createState() => _DarkotaViewAllState();
}

class _DarkotaViewAllState extends State<DarkotaViewAll> {
  List<DakotaModel> dData = [];
  List<Widget> itemsData = [];

  String typeCategory;
  int countAll;

  static Future<void> getPostsData(
      AuthProvider authProvider,
      DakotaProvider dakotaProvider,
      String category,
      BantuanUsaha bantuanUsaha) async {
    await DakotaApi.fetchDakota(authProvider, dakotaProvider, category);
  }

  void setCount(DakotaProvider dakotaProvider) {
    setState(() {
      countAll = dakotaProvider.dakotaList.length;
    });
  }

  Future<void> initDakota(String category) async {
    AuthProvider aauthProvider =
        Provider.of<AuthProvider>(context, listen: false);
    DakotaProvider ddakotaProvider =
        Provider.of<DakotaProvider>(context, listen: false);
    BantuanUsaha bbantuanUsaha =
        Provider.of<BantuanUsaha>(context, listen: false);
    await getPostsData(aauthProvider, ddakotaProvider, category, bbantuanUsaha);
  }

  @override
  void initState() {
    super.initState();
    DakotaProvider dakotaProvider =
        Provider.of<DakotaProvider>(context, listen: false);
    initDakota('all');
    DakotaProvider().dakotaList = [];
    setState(() {
      typeCategory = "all";
    });
    setCount(dakotaProvider);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    DakotaProvider dakotaProvider = Provider.of<DakotaProvider>(context);
    BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search, color: Colors.blueGrey),
                onPressed: () {
                  showSearch(context: context, delegate: ViewSearch());
                },
              ),
            ],
          ),
          body: (dakotaProvider.dakotaList.isEmpty)
              ? Center(
                  child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'mohon maaf saat ini server sedang sibuk',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 35, color: Colors.blueGrey),
                                  ),
                                  Text(
                                    'silakan tarik ke bawah tulisan ini\n untuk memperbarui data',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.blueGrey),
                                  ),
                                ],
                              )))))
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Container(
                    height: size.height,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "${dakotaProvider.dakotaList.length.toString()} total kelompok tani",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: RefreshIndicator(
                          onRefresh: _onRefresh,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
//                            physics: NeverScrollableScrollPhysics(),
                              itemCount: dakotaProvider.dakotaList.length,
                              itemBuilder: (context, index) {
                                final dakotaData =
                                    dakotaProvider.dakotaList[index];
                                return InkWellContainer(
                                    authProvider: authProvider,
                                    dakotaProvider: dakotaProvider,
                                    dakotaData: dakotaData,
                                    bantuanUsaha: bantuanUsaha);
                              }),
                        )),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    DakotaProvider dakotaProvider =
        Provider.of<DakotaProvider>(context, listen: false);
    initDakota('all');
    return setCount(dakotaProvider);
  }
}

class InkWellContainer extends StatelessWidget {
  const InkWellContainer({
    Key key,
    @required this.authProvider,
    @required this.dakotaProvider,
    @required this.dakotaData,
    @required this.bantuanUsaha,
  }) : super(key: key);

  final AuthProvider authProvider;
  final DakotaProvider dakotaProvider;
  final DakotaModel dakotaData;
  final BantuanUsaha bantuanUsaha;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: () async {
        await DakotaApi.getPersonalGroup(
            context, dakotaProvider, dakotaData.id, bantuanUsaha);
      },
      child: Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      dakotaData.namaKelompok,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dakotaData.namaKetua,
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      dakotaData.kelurahan,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 11, bottom: 11, right: 0, left: 10),
                  child: Image.asset(
                    "assets/kontjotanie.jpg",
                  ),
                )
              ],
            ),
          )),
    ));
  }
}

class ViewSearch extends SearchDelegate<DakotaModel> {

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = '';
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
  }

  void startSearch(String quey, DakotaProvider dakotaProvider) async {
    await DakotaApi.searchDakota(query, dakotaProvider);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    List<Map<String,dynamic>> suggestionList = [
      {
        'title' : 'Tanaman Pangan',
        'sub' : 'padi'
      },
      {
        'title' : 'Alsintan',
        'sub' : 'Tracktor'
      },
      {
        'title' : 'Hortikultura',
        'sub' : 'Semangka'
      },
      {
        'title' : 'Mangkujayan',
        'sub' : 'Konco Tani'
      },
      {
        'title' : 'Babadan',
        'sub' : 'Japan'
      },
    ];


    DakotaProvider dakotaProvider = Provider.of<DakotaProvider>(context, listen: false);

    startSearch(query, dakotaProvider);




    return (query.isEmpty) ? Center(
      child: (dakotaProvider.dakotaList.isEmpty) ? Text('maaf sesatu yang anda \ncari tidak tersedia') : ListView.builder(
          itemCount: suggestionList.length,
          itemBuilder: (context, index){
            final _fetch = suggestionList[index];
            return Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03, left: MediaQuery.of(context).size.width * 0.035),
              child: Row(
                children: <Widget>[
                  Icon(Icons.youtube_searched_for, color: Colors.blueGrey.shade50,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_fetch['title'], style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 24)),
                      Text(_fetch['sub'], style: TextStyle(color: Colors.blueGrey.shade200, fontSize: 18))
                    ],
                  ),
                ],
              ),
            );
          }
      ),
    ) : Consumer<BantuanUsaha>(
        builder: (_, bantuanUsaha, __){
          return Consumer<AuthProvider>(
              builder: (_, authProvider,__){
                return Consumer<DakotaProvider>(
                    builder: (_, dakotaProvider,__){
                      return ListView.builder(
                          itemCount: dakotaProvider.dakotaList.length,
                          itemBuilder: (context, index){
                            final dData = dakotaProvider.dakotaList[index];

                            return InkWellContainer(
                                authProvider: authProvider,
                                dakotaProvider: dakotaProvider,
                                dakotaData: dData,
                                bantuanUsaha: bantuanUsaha
                            );
                          }
                      );
                    }
                );
              }
          );
        }
    );
  }
}
