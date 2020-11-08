import 'package:dakota/dakota_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewAllSearch extends StatefulWidget {
  @override
  _ViewAllSearchState createState() => _ViewAllSearchState();
}

class _ViewAllSearchState extends State<ViewAllSearch> {

  TextEditingController searchInput = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final fData = [
      {
        "name":"Konco Tani",
        "ketuaKelompok":"Sutejo",
        "kelurahan":"Nambangrejo",
        "image":"kontjotanie.jpg"
      },{
        "name":"Tani Makmur",
        "ketuaKelompok":"Bowo",
        "kelurahan":"Bangunsari",
        "image":"kontjotanie.jpg"
      },
      {
        "name":"Tani Makmur",
        "ketuaKelompok":"Suroto",
        "kelurahan":"Kedungbanteng",
        "image":"kontjotanie.jpg"
      },
      {
        "name":"Tani Makmur",
        "ketuaKelompok":"Pardi",
        "kelurahan":"Patihan Wetan",
        "image":"kontjotanie.jpg"
      },
      {
        "name":"Subur Jaya",
        "ketuaKelompok":"Suyatno",
        "kelurahan":"Mirah",
        "image":"kontjotanie.jpg"
      },
      {
        "name":"Tani Makmur",
        "ketuaKelompok":"Sugiono",
        "kelurahan":"Ngebel",
        "image":"kontjotanie.jpg"
      },
      {
        "name":"Tani Makmur",
        "ketuaKelompok":"Basori",
        "kelurahan":"Pulung Merdika",
        "image":"kontjotanie.jpg"
      },
      {
        "name":"Tani Makmur",
        "ketuaKelompok":"Bambang",
        "kelurahan":"Sukorejo",
        "image":"kontjotanie.jpg"
      },
      {
        "name":"Tani Subur",
        "ketuaKelompok":"Rahmadi",
        "kelurahan":"Ponorogo",
        "image":"kontjotanie.jpg"
      }
    ];


    ScrollController controller = ScrollController();
    bool closeTopContainer = false;
    double topContainer = 0;

    List<Widget> itemsData = [];

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                      "assets/${post["image"]}",
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

    Widget searchResult = Expanded(
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
            }));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.blueGrey,), onPressed: (){ Navigator.of(context).pop();}),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: width * 0.6,
                height: height * 0.1,
                margin: EdgeInsets.only(right: width * 0.08),
                child: TextField(
                  controller: searchInput,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Cari Di sini',
                    alignLabelWithHint: false,
                  ),
                ),
              ),
              IconButton(icon: Icon(Icons.search, color: Colors.blueGrey,), onPressed: (){
                getPostsData();
              })
            ],
          ),
        ],
      ),
      body: (itemsData.isEmpty) ? Text('') : searchResult,
    );
  }
}
