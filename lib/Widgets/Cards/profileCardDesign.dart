import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:soulmate/Pages/profile.dart';

import 'circleimage.dart';

Widget profileCardDesign(double yukseklik, double genislik) {
  double height = yukseklik;
  double width = genislik;

  CarouselSlider carouselSlider = CarouselSlider.builder(
    itemCount: 5,
    itemBuilder: (BuildContext context, int itemIndex) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: height / 1.5,
              width: width / 1.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    height), // height yazdım çünkü ekran ne olursa olsun tamamen yuvarlak yapıcak.
                gradient: LinearGradient(
                    colors: [Color(0xff6DC8F3), Color(0xff73A1F9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff73A1F9),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: InkWell(
                child: circleImages(""),
                onTap: () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfilePage()));*/
                },
              ),
            ),
            Container(
              height: height / 1.2,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Ayşe Fatma Hayriye Merve",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: height /
                            2.5, // 2 TARAFTA HEIGHT EŞİT OLSUN DİYE ELLEME
                        width: height / 2.5,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(height)),
                          color: Colors.indigoAccent,
                        ),
                        child: Text(
                          "Test Çöz",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: height / 2.5,
                        width: height / 2.5,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(height)),
                          color: Colors.indigoAccent,
                        ),
                        child: Text(
                          "Ekle",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  return carouselSlider;
}