import 'dart:io';
import 'dart:math';
import 'package:dakota/Services/api/gallery.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/image_gallery/gallery.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:path/path.dart' as path;

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
    String generateRandomString(int len) {
      var r = Random();
      const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
    }
    String ogPath = image.path;
    DateTime today = new DateTime.now();
    String dir = path.dirname(ogPath);
    String dateSlug =
        "${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year.toString()}_${today.hour.toString().padLeft(2, '0')}-${today.minute.toString().padLeft(2, '0')}-${today.second.toString().padLeft(2, '0')}";
    String newPath = path.join(dir, 'dakotaGalery_${dateSlug}_${generateRandomString(5)}.jpg');
    image = image.renameSync(newPath);
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
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: <Widget>[
            ClipRRect(
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: PhotoView(
                  imageProvider: FileImage(image),
                  backgroundDecoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            //
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
    );
  }
}
