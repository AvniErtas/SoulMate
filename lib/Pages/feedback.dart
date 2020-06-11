import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/Widgets/dataSearch.dart';


class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {

  TextEditingController testAdiController = new TextEditingController();
  var rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTasarim2("Geri Bildirim"),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            TextWidget("Sorununuzu Giriniz",5),
            SizedBox(height: 10,),
            Center(child: TextWidget("E-posta / Kullanıcı Adı",1)),
            SizedBox(height: 10,),
            Center(child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              child: RaisedButton(
                child: Text("Gönder",style: TextStyle(color: Colors.white),),
                color: Colors.blue,
                onPressed: (){
                  AwesomeDialog(
                      context: context,
                      animType: AnimType.LEFTSLIDE,
                      headerAnimationLoop: false,
                      dialogType: DialogType.SUCCES,
                      title: 'Teşekkürler !!',
                      desc: "",
                      onDissmissCallback: () {})
                    ..show();
                },
              ),
            ),)
          ],
        ),
      ),
    );
  }

  Widget TextWidget(String title,int lines) {
    return TextFormField(
      maxLines: lines,
      controller: testAdiController,
      decoration: new InputDecoration(
        labelStyle: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
        hintText: title,
        fillColor: Colors.white,
        focusColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10.0),
          borderSide: new BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),

        //fillColor: Colors.green
      ),
      keyboardType: TextInputType.text,

    );
  }

}


