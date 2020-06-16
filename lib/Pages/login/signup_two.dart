////resizeToAvoidBottomPadding: false , yazma yerine tıklayınca klavyenin pixel taşmasını engelliyor.

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:soulmate/Tools/domain.dart';
import 'package:soulmate/main.dart';

class SignupTwo extends StatefulWidget {
  const SignupTwo({Key key}) : super(key: key);
  @override
  _SignupTwoState createState() => _SignupTwoState();
}

class _SignupTwoState extends State<SignupTwo> {
  File _imageFile;
  String percent = "0%";
  double percentDouble = 0.0;
  bool percentVisibilty = false;
  final globalKey = GlobalKey<ScaffoldState>();
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final cardWidth = min(deviceSize.width * 0.75, 360.0);
    const cardPadding = 16.0;
    final textFieldWidth = cardWidth - cardPadding * 2;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: globalKey,
        resizeToAvoidBottomPadding: false ,
        backgroundColor: Color(0xff62bafc),
        body: SafeArea(child: fotoEkle()),
      ),
    );
  }

  Future<Null> _pickImageFromGallery() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    setState(() => this._imageFile = imageFile);
    print(imageFile.lengthSync());
  }

  Future<Null> _pickImageFromCamera() async {
    final File imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 75);
    setState(() => this._imageFile = imageFile);
    print(imageFile.lengthSync());
  }

  Widget fotoEkle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        /* Column(
          children: <Widget>[
            Text("Yaz Kızım"),
            KonuSecimi(),
          ],
        ), */
        Text(
          "Profil Bilgileri",
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
         Padding(
          padding: const EdgeInsets.all(20),
          child: new TextFormField(
              textInputAction: TextInputAction.next,
              
            decoration: new InputDecoration(
              icon: Icon(Icons.person),
              labelStyle: TextStyle(color: Colors.white),
              labelText: "Ad Soyad Giriniz",
              fillColor: Colors.white,
              focusColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
              ),
            

              //fillColor: Colors.green
            ),
            validator: (val) {
              if (val.length == 0) {
                return "İsim boş olamaz!";
              } else {
                return null;
              }
            },
              onFieldSubmitted: (_) => FocusScope.of(globalKey.currentContext).nextFocus(),
            controller: nameController,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: new TextFormField(
            decoration: new InputDecoration(
              icon: Icon(Icons.person),
              labelStyle: TextStyle(color: Colors.white),
              labelText: "Kullanıcı adı giriniz",
              fillColor: Colors.white,
              focusColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
              ),
            

              //fillColor: Colors.green
            ),
            validator: (val) {
              if (val.length == 0) {
                return "Kullanıcı adı boş olamaz!";
              } else {
                return null;
              }
            },
            controller: usernameController,
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Lütfen Profil Fotoğrafı Yükleyiniz (İsteğe bağlı)",
                  style: TextStyle(color: Colors.black),
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
                    ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                        height: 150,
                        width: 100,
                        child: this._imageFile == null
                            ? Container()
                            : Image.file(
                                this._imageFile,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Visibility(
                  visible: percentVisibilty,
                  child: CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 5.0,
                    percent: percentDouble,
                    center: new Text(percent),
                    progressColor: Colors.green,
                  ),
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
                    // Replace with a Row for horizontal icon + text

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
                        "Atla",
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
                  if (usernameController.text.isNotEmpty || nameController.text.isNotEmpty)
                    {
                      startUpload(),
                    }
                  else
                    {
                      globalKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                        'Kullanıcı adı girmelisiniz!',
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
                      "Devam et",
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
 startUpload() async {
   FirebaseUser user = await FirebaseAuth.instance.currentUser();

   UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
   userUpdateInfo.displayName = usernameController.text.toString();
   user.updateProfile(userUpdateInfo);


    if (_imageFile == null  ) {
      _username_kayit(user.uid);
    }else {
//      userUpdateInfo.photoUrl = user.uid+".jpg";
//    String ext = _imageFile.path.split('.').last;
    uploadImage(user.uid);
    }

  }
Future<void> uploadImage(String uid) async {
    var dio = Dio();
    FormData formData = FormData.fromMap({
      "uid": uid,
      "username": usernameController.text.toString(),
      "name": nameController.text.toString(),
      "file": await MultipartFile.fromFile(_imageFile.path),
    });
    Response response = await dio.post(
      Domain().getDomainApi()+"/user/addUsernameP",
      data: formData,
      onSendProgress: (int sent, int total) {
        if (total != -1) {
          setState(() {
            percentVisibilty = true;
            percent = ((sent / total) * 100).toStringAsFixed(0) + "%";
            percentDouble = (sent / total);
          });

          print(percent);
        }
      },
    );
    debugPrint(response.toString());
    setState(() {
      // percent = "Completed";
      percentDouble = 1.0;
    });
    if (response.statusCode == 200)
    {
     _next_page();
    }
 
  }

 Future<void> _username_kayit(String uid) async {
    var response =
        await http.post(Domain().getDomainApi()+"/user/addUsername", body: {
      "uid": uid,
      "username": usernameController.text.toString(),
      "name": nameController.text.toString(),
    });
    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
      // return Gonderi.fromJsonMap(json.decode(response.body));
      _next_page();
    } else {
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());
    }

  }

  _next_page() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainWidget()),
          (Route<dynamic> route) => false,
    );
  }
}
