import 'package:flutter/material.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/Tools/kategoriResimleri.dart';
import 'package:soulmate/Widgets/circleCategory.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isTest = false;
  List<bool> liste = List<bool>();
  List<String> userID = ["Ayşe", "Fatma", "Hayriye"];

  List<String> bildirimler = [
    "Mehmet sana Arkadaşlık isteği gönderdi",
    "Ailene Ne Kadar Düşkünsün Testini Çözdü",
  ];

  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < 10; i++) {
      liste.add(false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTasarim2(title : "Bildirimler",),
      body: ListView.separated(
        separatorBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          color: Colors.blueGrey,
          height: 1.2,

        ),
        itemCount: bildirimler.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: (){},
            onLongPress: (){},
            title: Text(bildirimler[index]),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                alignment: Alignment.center,
                width: 60,
                height: 60,
                child:
                    Image.asset(kategoriImageURL[index], fit: BoxFit.contain),
              ),
            ),
          );
        },
      ),
    );
  }


  /*Widget imageWidget() {
    return Container(
      height: 60,
      width: 60,
      child: CircleAvatar(
        backgroundImage: AssetImage("assets/profile.jpeg"),
      ),
    );
  }*/

  /*Widget takipEtButton() {
    return RaisedButton(
      onPressed: () {},
      color: Colors.blue,
      child: Text(
        "Takip Et",
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
      elevation: 2,
    );
  }*/


}
