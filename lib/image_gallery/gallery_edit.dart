import 'package:dakota/Services/api/gallery.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/gallery_list.dart';
import 'package:dakota/model/gallery.dart';
import 'package:flutter/material.dart';

class GalleryEdit extends StatefulWidget {
  final int id;
  final List<Gallery> gData;
  GalleryEdit(this.id, this.gData);

  @override
  _GalleryEditState createState() => _GalleryEditState();
}

class _GalleryEditState extends State<GalleryEdit> {
  bool edited = false;
  GalleryApi galleryApi = GalleryApi();

  TextEditingController judulController = TextEditingController();
  TextEditingController subJudulController = TextEditingController();
  TextEditingController detailsController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textSetter(widget.gData.first.title, widget.gData.first.subtitle, widget.gData.first.details);
  }

  void textSetter(String title, String subtitle, String details){
     setState(() {
                judulController = new TextEditingController(text: title);
                subJudulController = new TextEditingController(text: subtitle);
                detailsController = new TextEditingController(text: details);
              });
  }

  void setEd(bool edit){
    setState(() {
      edited = edit;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
                  child:  (widget.gData.isNotEmpty)
                          ? SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.blueGrey,
                                              size: SizeConfig.textMultiplier * 4,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }),
                                        Text(
                                          'Sunting Caption',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        SizedBox(
                                          width: SizeConfig.widthMultiplier * 10,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 4,
                                    ),
                                    ListView(
                                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 5),
                                      shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: <Widget>[
                                      Container(
                                        width: SizeConfig.widthMultiplier * 80,
                                        height: SizeConfig.heightMultiplier * 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: NetworkImage(widget.gData.first.imageUrl),
                                                fit: BoxFit.cover)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                SizeConfig.widthMultiplier * 10),
                                        child: Column(
                                          children: <Widget>[
                                            TextField(
                                              controller: judulController,
                                              decoration: InputDecoration(
                                                labelText: 'Judul',
                                              ),
                                            ),
                                            TextField(
                                              controller: subJudulController,
                                              decoration: InputDecoration(
                                                labelText: 'sub judul',
                                              ),
                                            ),
                                            TextField(
                                              controller: detailsController,
                                              decoration: InputDecoration(
                                                labelText: 'Rincian Kegiatan',
                                              ),
                                              keyboardType:
                                                  TextInputType.multiline,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    FloatingActionButton.extended(
                                                        disabledElevation: 0,
                                                        heroTag: "SAVE",
                                                        icon: Icon(Icons.save),
                                                        label: edited
                                                            ? Text("TERSIMPAN")
                                                            : Text("SIMPAN"),
                                                        backgroundColor: edited
                                                            ? Colors.grey
                                                            : Theme.of(context)
                                                                .primaryColor,
                                                        onPressed: edited
                                                            ? null
                                                            : () async {
                                                          bool ed;
                                                          await galleryApi.stringUpdate({
                                                            'id' : widget.gData.first.id.toString(),
                                                            'title' : judulController.text,
                                                            'subtitle' : subJudulController.text,
                                                            'details' : detailsController.text
                                                          }, (response)=> (response == "success updating item") ? ed = true : ed == false);
                                                          setEd(ed);
                                                        }),
                                              ),
                                              (edited)
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: FloatingActionButton
                                                          .extended(
                                                              disabledElevation:
                                                                  0,
                                                              heroTag: "BACK",
                                                              icon: Icon(
                                                                  Icons.save),
                                                              label:
                                                                  Text('KEMBALI'),
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pushReplacement(MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                GalleryList()));
                                                              }),
                                                    )
                                                  : Text(''),
                                            ],
                                          )
                                        ],
                                      ),
                                    ]),
                                  ]),
                          )
                          : Center(child: CircularProgressIndicator()),
                )
    );
  }
}
