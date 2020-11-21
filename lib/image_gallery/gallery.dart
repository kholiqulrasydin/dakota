import 'dart:io';

import 'package:dakota/Services/api/gallery.dart';
import 'package:dakota/image_gallery/details_page.dart';
import 'package:dakota/image_gallery/edit_image.dart';
import 'package:dakota/image_gallery/select_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';

class FrontGallery extends StatefulWidget {
  @override
  _FrontGalleryState createState() => _FrontGalleryState();
}

class _FrontGalleryState extends State<FrontGallery> {
  double appbarHeight = AppBar().preferredSize.height;
  GalleryApi galleryApi = new GalleryApi();
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Future.delayed(Duration(seconds: 0)).then(
            (value) => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => EditPhotoScreen(
              arguments: [_image],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          child: RaisedButton(
            padding: EdgeInsets.all(0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 12,
                ),
                Icon(Icons.search, color: Color(0xff787878)),
                SizedBox(width: 8),
                Expanded(
                  child:
                      Text("data", style: TextStyle(color: Color(0xff787878))),
                  /* TextField(
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none),
                  ), */
                ),
              ],
            ),
            elevation: 0,
            splashColor: Colors.transparent,
            // highlightColor: Colors.transparent,
            highlightElevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            onPressed: () {},
          ),
          // color: Colors.white,
          // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          height: appbarHeight - 16.0,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Color(0xff787878),
            ),
            tooltip: 'Image search',
            onPressed: () async {
              await getImage();
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: "Manage following",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SelectBottomPanel()));
            },
          ),
          SizedBox(width: 4),
        ],
        elevation: 0,
      ),
      body: FutureBuilder(
        future: galleryApi.fetchAll((response) => response),
        builder: (BuildContext context, AsyncSnapshot snapshot) =>
            snapshot.hasData
                ? StaggeredGridView.count(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    crossAxisCount: 4,
                    children: snapshot.data.map<Widget>((item) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)
                                      => DetailsPage(
                                        imagePath: item['image_url'],
                                        title: item['title'],
                                        executedBy: item['uploader'],
                                        subtitle: item['subtitle'],
                                        details: item['details'],
                                        index: item['created_at'].toString(),
                                      )));
                                },
                                child: Card(
                                  elevation: 2,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0)),
                                  margin: EdgeInsets.all(0),
                                  child: Image(
                                    image: NetworkImage(item['image_url']),
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    item['title'],
                                    maxLines: 2,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.more_horiz),
                                  splashColor: Colors.transparent,

                                  // highlightColor: null,
                                  onPressed: () {
                                    print(item);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        padding: EdgeInsets.all(8),
                      );
                    }).toList(),
                    staggeredTiles: snapshot.data
                        .map<StaggeredTile>((_) => StaggeredTile.fit(2))
                        .toList(),
                    // .toList(),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}
