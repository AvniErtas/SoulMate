import 'package:flutter/material.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:tanismauygulamasi/Sayfalar/appbar.dart';
import 'package:tanismauygulamasi/Sayfalar/gradientcard.dart';
import 'package:tanismauygulamasi/onur_pages/gradient.dart';

class PaylasmaSonrasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double cardWidth = width * 0.2;
    double cardHeight = height * 0.15;
    return Scaffold(
      appBar: appBarTasarim("title"),
      floatingActionButton: new FloatingActionButton(
        child: const Icon(Icons.forward),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation. endFloat,
      body: ListView.builder(
        shrinkWrap: true,
        itemCount:10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: cardHeight,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GradientCard(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              gradient: GradientColors2.bourbon,
              child: Center(
                child: ListTile(
                  title: Text(
                    'Buraya Paylasma Sonrası Soru Önerilecek',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
