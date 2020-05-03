import 'package:flutter/material.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/Widgets/Cards/gradientcard.dart';

class KategoriBolumu extends StatefulWidget {
  @override
  _KategoriBolumuState createState() => _KategoriBolumuState();
}

class _KategoriBolumuState extends State<KategoriBolumu> {
  @override
  Widget build(BuildContext context) {
    return kategoriler();
  }

Widget kategoriler() {
  List<String> kategoriIsmi = [
    "Eğlence",
    "Kitap",
    "İş",
    "Film-Dizi",
    "Gezi",
    "Aile",
    "Teknoloji",
    "Yaşam Tarzı",
    "Aşk",
    "Yemek",
    "Ahlaki İkilem",
    "Diğer"
  ];
  List<String> kategoriImageURL = [
    "images/kategoriresimler/Eglence.png",
    "images/kategoriresimler/Kitap.png",
    "images/kategoriresimler/is.png",
    "images/kategoriresimler/Film-Dizi.png",
    "images/kategoriresimler/Gezi.png",
    "images/kategoriresimler/Aile.png",
    "images/kategoriresimler/Teknoloji.png",
    "images/kategoriresimler/YasamTarzi.png",
    "images/kategoriresimler/ask.png",
    "images/kategoriresimler/Yemek.png",
    "images/kategoriresimler/ahlaki-ikilem.png",
    "images/kategoriresimler/diger.png"
  ];

    return Scaffold(
      appBar: appBarTasarim(""),
      body: Container(
        decoration: BoxDecoration(
          gradient: GradientColors.arkaplan,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemCount: kategoriIsmi.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                return kategoriView(
                  context,
                  kategoriIsmi[index],
                  kategoriImageURL[index],
                  index,
                );
              }),
        ),
      ),
    );
  }

  Widget kategoriView(
    BuildContext context,
    String kategoriIsim,
    String kategoriImage,
    int index,
  ) {
    return GradientCard(
      margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
      gradient: renkler[index].gradient,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              kategoriIsim,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontFamily: 'roboto',
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                kategoriImage,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
