import 'package:dakota/Services/api/gallery.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/image_gallery/gallery_edit.dart';
import 'package:dakota/image_gallery/select_image.dart';
import 'package:dakota/model/gallery.dart';
import 'package:dakota/ruang_admin.dart';
import 'package:flutter/material.dart';

class GalleryList extends StatefulWidget {
  @override
  _GalleryListState createState() => _GalleryListState();
}

class _GalleryListState extends State<GalleryList> {

  final GlobalKey<ScaffoldState> _galleryListKey = new GlobalKey<ScaffoldState>();
  double appbarHeight = AppBar().preferredSize.height;
  GalleryApi galleryApi = GalleryApi();
  @override
  Widget build(BuildContext context) {

    void _onPopUpSelected(String value) async {
      switch(value.substring(0,1)){
        case 'e':
          List<Gallery> gData = [];
          print('editing ${value.substring(1)}');
          await galleryApi.fetchOnce(int.parse(value.substring(1)), (response) => response).then((value) {
            gData = value.map((e) => Gallery.formMap(e)).toList();
          });
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => GalleryEdit(int.parse(value.substring(1)), gData)));
          break;

        case 'd':
          print('deleting ${value.substring(1)}');
          await galleryApi.delete(value.substring(1), (response) {
            if(response.statusCode == 200){
              _galleryListKey.currentState.showSnackBar(SnackBar(content: Text('Item telah dihapus', style: TextStyle(color: Colors.white),), backgroundColor: Colors.blueAccent.shade400, duration: Duration(seconds: 5),));
              Navigator.pop(context);
            }else{
              _galleryListKey.currentState.showSnackBar(SnackBar(content: Text('Mohon maaf, kesalahan server', style: TextStyle(color: Colors.white),), backgroundColor: Colors.redAccent.shade400, duration: Duration(seconds: 5),));
              Navigator.pop(context);
            }
          });
          setState(() {
            galleryApi = new GalleryApi();
          });
          break;

      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Data Kegiatan'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RuangAdmin()));
            }),
      ),
      body: FutureBuilder(
        future: galleryApi.fetchAll((response) => response),
        builder: (BuildContext context, AsyncSnapshot snapshot) =>
        snapshot.hasData
            ? ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 2,
              vertical: SizeConfig.heightMultiplier * 1),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            final _gallery = snapshot.data[index];
            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: SizeConfig.imageSizeMultiplier * 10,
                    height: SizeConfig.imageSizeMultiplier * 10,
                    child: Image.network(_gallery['image_url']),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(
                          right: SizeConfig.widthMultiplier * 5),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _gallery['title'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 3,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1,
                            ),
                            Container(
                              width: SizeConfig.widthMultiplier * 60,
                              child: Text(
                                _gallery['uploader'],
                                maxLines: 3,
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    color: Colors.grey[500]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: PopupMenuButton(
                        onSelected: _onPopUpSelected,
                        itemBuilder: (BuildContext context) =>
                        [
                          PopupMenuItem(
                              value: 'e${_gallery['id']}',
                              child: Text('Edit Caption')
                          ),
                          PopupMenuItem(
                            value: 'd${_gallery['id']}',
                            child: Text('Delete Foto'),
                          ),
                        ])
                  )
                ],
              ),
            );
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
