import 'dart:io';

import 'package:dakota/image_gallery/edit_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectBottomPanel extends StatefulWidget {
  const SelectBottomPanel({
    Key key,
  }) : super(key: key);

  @override
  _SelectBottomPanelState createState() => _SelectBottomPanelState();
}

class _SelectBottomPanelState extends State<SelectBottomPanel> {
  File _image;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Spacer(),
            Text(
              "Silahkan Pilih Foto untuk diupload",
              style: Theme.of(context).textTheme.headline4,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          await getImage();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          height: MediaQuery.of(context).size.width / 2 / 0.6625,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 2 - 14,
                                height: MediaQuery.of(context).size.width /
                                    2 /
                                    0.6625,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2),
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 3),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Opacity(
                                      opacity: 1,
                                      child: Image.asset(
                                        'assets/homescreen.jpg',
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 60.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context).primaryColor,
                                            width: 1),
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.2),
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(
                                        Icons.image,
                                        color: Theme.of(context).primaryColor,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Photos",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "Select an image, and edit easily in seconds. Upload and share with your partners.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}