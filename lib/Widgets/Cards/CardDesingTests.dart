import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:soulmate/Tools/CustomCardShapePainter.dart';
import 'package:soulmate/model/test.dart';

CarouselSlider cardDesingTests({@required List<Test> testler,Function onClick,Function pageChanged}) {

  return  CarouselSlider.builder(
    itemCount: testler.length,
    onPageChanged: (index) => pageChanged(index),

    itemBuilder: (BuildContext context, int itemIndex) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onClick(itemIndex);
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                    colors: [Color(0xff6DC8F3), Color(0xff73A1F9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff73A1F9),
                    blurRadius: 5,
                    //offset: Offset(0, 6),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: CustomPaint(
                size: Size(100, 150),
                painter: CustomCardShapePainter(
                  12,
                  Color(0xff6DC8F3),
                  Color(0xff73A1F9),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      testler[itemIndex].testAdi,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 20),
                      child: Text(
                        '${itemIndex + 1}/${testler.length}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}


