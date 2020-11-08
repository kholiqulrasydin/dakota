import 'package:dakota/dakota_view.dart';
import 'package:flutter/material.dart';


class DarkotaViewAll extends StatefulWidget {
  @override
  _DarkotaViewAllState createState() => _DarkotaViewAllState();
}

class _DarkotaViewAllState extends State<DarkotaViewAll> {


  final fData = [
    {
      "name":"Konco Tani",
      "ketuaKelompok":"Sutejo",
      "kelurahan":"Nambangrejo",
      "image":"kontjotanie.png"
    },{
      "name":"Tani Makmur",
      "ketuaKelompok":"Bowo",
      "kelurahan":"Bangunsari",
      "image":"kontjotanie.png"
    },
    {
      "name":"Tani Makmur",
      "ketuaKelompok":"Suroto",
      "kelurahan":"Kedungbanteng",
      "image":"kontjotanie.png"
    },
    {
      "name":"Tani Makmur",
      "ketuaKelompok":"Pardi",
      "kelurahan":"Patihan Wetan",
      "image":"kontjotanie.png"
    },
    {
      "name":"Subur Jaya",
      "ketuaKelompok":"Suyatno",
      "kelurahan":"Mirah",
      "image":"kontjotanie.png"
    },
    {
      "name":"Tani Makmur",
      "ketuaKelompok":"Sugiono",
      "kelurahan":"Ngebel",
      "image":"kontjotanie.png"
    },
    {
      "name":"Tani Makmur",
      "ketuaKelompok":"Basori",
      "kelurahan":"Pulung Merdika",
      "image":"kontjotanie.png"
    },
    {
      "name":"Tani Makmur",
      "ketuaKelompok":"Bambang",
      "kelurahan":"Sukorejo",
      "image":"kontjotanie.png"
    },
    {
      "name":"Tani Subur",
      "ketuaKelompok":"Rahmadi",
      "kelurahan":"Ponorogo",
      "image":"kontjotanie.png"
    }
  ];


  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = fData;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DakotaView(post['name'])));
        },
        child: Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
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
                        post["name"],
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        post["ketuaKelompok"],
                        style: const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        post["kelurahan"],
                        style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/images/${post["image"]}",
                    height: double.infinity,
                  )
                ],
              ),
            )),
      ));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {

      double value = controller.offset/119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.blueGrey,), onPressed: (){Navigator.of(context).pop();}),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search, color: Colors.blueGrey),
                onPressed: () {},
              ),
            ],
          ),
          body: Container(
            height: size.height,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "356 total kelompok tani",
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: closeTopContainer?0:1,
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: size.width,
                      alignment: Alignment.topCenter,
                      height: closeTopContainer?0:categoryHeight,
                      child: categoriesScroller),
                ),
                Expanded(
                    child: ListView.builder(
                        controller: controller,
                        itemCount: itemsData.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          double scale = 1.0;
                          if (topContainer > 0.5) {
                            scale = index + 0.5 - topContainer;
                            if (scale < 0) {
                              scale = 0;
                            } else if (scale > 1) {
                              scale = 1;
                            }
                          }
                          return Opacity(
                            opacity: scale,
                            child: Transform(
                              transform:  Matrix4.identity()..scale(scale,scale),
                              alignment: Alignment.bottomCenter,
                              child: Align(
                                  heightFactor: 0.7,
                                  alignment: Alignment.topCenter,
                                  child: itemsData[index]),
                            ),
                          );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.teal.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Bidang Usaha Tanaman Pangan",
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "20 Kelompok",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.blue.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Holtikultura",
                          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "20 Kelompok",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.lightBlueAccent.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Biofarmaka",
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "20 Kelompok",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.blueGrey.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Biofarmaka",
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "20 Kelompok",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.amber.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Biofarmaka",
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "20 Kelompok",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
