import 'dart:io';
import 'package:dakota/Services/api/gallery.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/image_gallery/gallery.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class SaveImageScreen extends StatefulWidget {
  final List arguments;

  SaveImageScreen({this.arguments});

  @override
  _SaveImageScreenState createState() => _SaveImageScreenState();
}

class _SaveImageScreenState extends State<SaveImageScreen> {
  File image;
  bool savedImage;

  TextEditingController judulController = TextEditingController();
  TextEditingController subJudulController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    image = widget.arguments[0];
    savedImage = false;
  }

  Future saveImage(String judul, String subjudul,
      String captions) async {
    renameImage();
    await GallerySaver.saveImage(image.path, albumName: "Dakota");
    setState(() {
      savedImage = true;
    });
    await GalleryApi().insert(
        {'title': judul, 'subtitle': subjudul, 'details': captions},
        image, print);
  }

  void renameImage() {
    String ogPath = image.path;
    List<String> ogPathList = ogPath.split('/');
    String ogExt = ogPathList[ogPathList.length - 1].split('.')[1];
    DateTime today = new DateTime.now();
    String dateSlug =
        "${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year.toString()}_${today.hour.toString().padLeft(2, '0')}-${today.minute.toString().padLeft(2, '0')}-${today.second.toString().padLeft(2, '0')}";
    image = image.renameSync(
        "${ogPath.split('/image')[0]}/PhotoEditor_$dateSlug.$ogExt");
    print(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: (!savedImage) ? Text(
          "Upload Foto",
        ) : Text('Foto Tersimpan'),
        actions: <Widget>[
          (!savedImage) ? Text('') : IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => FrontGallery()));
          })
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          color: Colors.white,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              ClipRRect(
                child: Container(
                  color: Theme.of(context).hintColor,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: PhotoView(
                    imageProvider: FileImage(image),
                    backgroundDecoration: BoxDecoration(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
              ),
              //
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 10),
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
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton.extended(
                            disabledElevation: 0,
                            heroTag: "SAVE",
                            icon: Icon(Icons.save),
                            label: savedImage ? Text("TERUNGGAH") : Text("UNGGAH"),
                            backgroundColor: savedImage
                                ? Colors.grey
                                : Theme.of(context).primaryColor,
                            onPressed: savedImage
                                ? null
                                : () async {
                              saveImage(
                                  judulController.text,
                                  subJudulController.text,
                                  detailsController.text);
                            }
                            ),
                      ),
                      (savedImage) ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton.extended(
                            disabledElevation: 0,
                            heroTag: "BACK",
                            icon: Icon(Icons.save),
                            label: Text('KEMBALI'),
                            backgroundColor: Theme.of(context).primaryColor,
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => FrontGallery()));
                            }
                        ),
                      ) : Text(''),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Center(
                        child: Icon(
                          Icons.info,
                          color: Theme.of(context).accentColor.withOpacity(0.6),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Center(
                          child: Text(
                            "Note - The images are saved in the best possible quality.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
