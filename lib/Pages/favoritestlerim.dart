import 'package:flutter/material.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/Tools/kategoriResimleri.dart';
import 'package:soulmate/Widgets/AppBarWithScaffold.dart';
import 'package:soulmate/Widgets/Cards/gradientcard.dart';

class FavoriTestlerim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double cardHeight = height * 0.15;

    return Scaffold(
      appBar: appBarTasarim2(title: "Favorilerim",context: context),
      backgroundColor: Colors.lightBlueAccent,
      body: ekran(width,height),
    );
  }

  Widget ekran(width, height) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: height*0.15,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: GradientCard(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            gradient: GradientColors.cardProfile,
            child: Center(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: width * 0.2,
                    height: height * 0.08,
                    child: Image.asset(kategoriImageURL[index],
                        fit: BoxFit.contain),
                  ),
                ),
                title: Text(
                  "1",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
