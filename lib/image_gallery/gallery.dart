import 'dart:io';

import 'package:dakota/Services/api/gallery.dart';
import 'package:dakota/Services/providers/user.dart';
import 'package:dakota/home.dart';
import 'package:dakota/image_gallery/details_page.dart';
import 'package:dakota/image_gallery/edit_image.dart';
import 'package:dakota/image_gallery/gallery_edit.dart';
import 'package:dakota/image_gallery/select_image.dart';
import 'package:dakota/model/gallery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FrontGallery extends StatefulWidget {
  @override
  _FrontGalleryState createState() => _FrontGalleryState();
}

class _FrontGalleryState extends State<FrontGallery> {
  double appbarHeight = AppBar().preferredSize.height;
  GalleryApi galleryApi = GalleryApi();
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
    UserProvider userProvider = Provider.of<UserProvider>(context);
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
                // Icon(Icons.search, color: Color(0xff787878)),
                SizedBox(width: 8),
                Expanded(
                  child:
                      Text("Galeri", style: TextStyle(color: Color(0xff787878))),
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
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blueGrey,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
            }),
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
                                (userProvider.personalUser.first.privileges != 0) ?PopupMenuButton(
                                  onSelected: _onPopUpSelected,
                                    itemBuilder: (BuildContext context) =>
                                    [
                                      PopupMenuItem(
                                        value: 'e${item['id']}',
                                        child: Text('Edit Caption')
                                      ),
                                      PopupMenuItem(
                                        value: 'd${item['id']}',
                                        child: Text('Delete Foto'),
                                      ),
                                    ]
                                ) : Icon(Icons.arrow_forward)
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

  void _onPopUpSelected(String value) async {
    switch(value.substring(0,1)){
      case 'e':
        print('editing ${value.substring(1)}');
        List<Gallery> gData = [];
        await galleryApi.fetchOnce(int.parse(value.substring(1)), (response) => response).then((value) {
          gData = value.map((e) => Gallery.formMap(e)).toList();
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => GalleryEdit(int.parse(value.substring(1)), gData)));
        break;

        case 'd':
          print('deleting ${value.substring(1)}');
          await galleryApi.delete(value.substring(1), (response) => print(response));
          setState(() {
            galleryApi = new GalleryApi();
          });
        break;

    }
  }
}
