import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImagePickerExample extends StatefulWidget {
  const ImagePickerExample({Key key, this.uid}) : super(key: key);
  final String uid;
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState(uid);
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  _ImagePickerExampleState(this.uid);
  String uid;
  File _imageFile;
  final globalKey = GlobalKey<ScaffoldState>();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: globalKey,
        backgroundColor: Color(0xff62bafc),
        body: SafeArea(child: fotoEkle()),
      ),
    );
  }

  Future<Null> _pickImageFromGallery() async {
    final imageFile =
        await _picker.getImage(source: ImageSource.gallery);
    final File file = File(imageFile.path);
    setState(() => this._imageFile = file);
  }

  Future<Null> _pickImageFromCamera() async {
    final imageFile = await _picker.getImage(
        source: ImageSource.camera, imageQuality: 85);
    final File file = File(imageFile.path);
    setState(() => this._imageFile = file);
  }

  Widget fotoEkle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(

              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Lütfen bilgi almak istediğiniz fotoğrafı yükleyiniz",
                  style: TextStyle(color: Colors.white,fontSize: 16),
                ),
              ),
            ),
            Align(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.photo_camera),
                          onPressed: () async => await _pickImageFromCamera(),
                          tooltip: 'Shoot picture',
                        ),
                        IconButton(
                          icon: Icon(Icons.photo),
                          onPressed: () async => await _pickImageFromGallery(),
                          tooltip: 'Pick from gallery',
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      height: 220,
                      width: 150,
                      child: this._imageFile == null
                          ? Container()
                          : Image.file(
                              this._imageFile,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ButtonTheme(
                height: 30.0,
                child: FlatButton(
                  onPressed: () => {
                    Navigator.pop(context),
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  color: Colors.red,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.backspace,
                          size: 15,
                        ),
                      ),
                      Text(
                        "Geri",
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                ),
              ),
            ),
            ButtonTheme(
              height: 30.0,
              child: FlatButton(
                onPressed: () => {
                  if (_imageFile != null)
                    {
                    /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OnaySayfasi(_imageFile, uid))),*/
                    }
                  else
                    {
                      globalKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                        'Fotoğraf yüklemelisiniz!',
                        textAlign: TextAlign.center,
                      )))
                      //  debugPrint("dosya yok");
                    }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: Colors.green,
                padding: EdgeInsets.all(3.0),
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.check,
                        size: 15,
                      ),
                    ),
                    Text(
                      "Tamam",
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
