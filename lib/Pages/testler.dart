import 'package:flutter/material.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Tools/kategoriResimleri.dart';
import 'package:soulmate/Widgets/Cards/gradientcard.dart';

import 'Kesfet/filterchip.dart';

enum WhyFarther { favoritest, sonracoz, paylas }

class Testler extends StatefulWidget {
  bool _isKesfet;
  Testler(this._isKesfet);

  @override
  _TestlerState createState() => _TestlerState();
}

class _TestlerState extends State<Testler> {
  //String _selection;
  WhyFarther _selection;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double cardWidth = width * 0.2;
    double cardHeight = height * 0.15;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: GradientColors.Background1,
        ),
        child: Column(
          children: <Widget>[
            Align(
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => Material(
                        type: MaterialType.transparency,
                        child: Center( // Aligns the container to center
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: FilterChipDisplay(),
                          ),
                        ),
                      )
                  );
                },
                child: Icon(
                  Icons.filter_list,
                  size: 30,
                ),
              ),
              alignment: Alignment.centerRight,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: cardHeight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GradientCard(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      gradient: GradientColors.anasayfaswiper,
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
                            'Lorem ipsum dolor sit amet, ante metus, in etiam diam.',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'Soru Sayısı: 15',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          trailing: popUp(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget popUp() {
    return PopupMenuButton<WhyFarther>(
      elevation: 4,
      icon: Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      onSelected: (WhyFarther result) {
        setState(() {
          _selection = result;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.favoritest,
          child: Text("Favorilerime Ekle",
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.sonracoz,
          child: Text(
            "Daha sonra çöz",
            style: TextStyle(fontSize: 15),
          ),
        ),
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.paylas,
          child: Text(
            "Paylaş",
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
