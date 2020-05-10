import 'package:flutter/material.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/Widgets/Cards/gradientcard.dart';

enum WhyFarther { favoritest, sonracoz, paylas }

class SonucInceleme extends StatefulWidget {
  @override
  _SonucIncelemeState createState() => _SonucIncelemeState();
}

class _SonucIncelemeState extends State<SonucInceleme> {
  WhyFarther _selection;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double cardWidth = width * 0.2;
    double cardHeight = height * 0.15;
    return Scaffold(
      appBar: appBarTasarim(""),
      body: Container(
        decoration: BoxDecoration(
          gradient: GradientColors.Background1,
        ),
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
                gradient: GradientColors.lovetonight,
                child: Center(
                  child: ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset("assets/profile.jpeg"),
                        ),
                        VerticalDivider(
                          color: Colors.white,
                          width: 10,
                          thickness: 1.50,
                        ),
                      ],
                    ),
                    title: Text(
                      'Avni Ertaş',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Test Puanı : ',
                            style: TextStyle(
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "35",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
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
    );
  }

  Widget popUp() {
    return PopupMenuButton<WhyFarther>(
      elevation: 4,
      icon: Icon(
        Icons.share,
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
