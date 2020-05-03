import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:soulmate/Tools/CustomCardShapePainter.dart';


class GirisSayfasi  extends KFDrawerContent {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi>
    with SingleTickerProviderStateMixin {
  double width;
  double height;
  Duration myDuration = Duration(seconds: 1);
  AnimationController _controller;
  Animation animation;
  Animation animation2;
  SequenceAnimation siralianimasyon;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: myDuration,
    );

    siralianimasyon = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: -200, end: 200), // Opacity için
            from: Duration.zero,
            to: Duration(seconds: 1),
            tag: "translate1")
        .addAnimatable(
            animatable: Tween<double>(begin: 400, end: 5),
            from: Duration(seconds: 1),
            to: Duration(seconds: 2),
            tag: "translate2")
        .addAnimatable(
            animatable: Tween<double>(begin: -200, end: 200),
            from: Duration(seconds: 2),
            to: Duration(seconds: 3),
            tag: "translate3")
        .animate(_controller);
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   width = MediaQuery.of(context).size.width;
   height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: Colors.black,
                              ),
                              onPressed: widget.onMenuPressed,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          width: width,
                          height: height * 0.55,
                        ),
                        Transform.translate(
                          offset:
                              Offset(siralianimasyon["translate1"].value, 0),
                          child: circleImages("testsec"),
                        ),
                        Transform.translate(
                          offset: Offset(siralianimasyon["translate2"].value,
                              height * 0.15),
                          child: circleImages("sonucincele"),
                        ),
                        Transform.translate(
                          offset: Offset(siralianimasyon["translate3"].value,
                              height * 0.3),
                          child: circleImages("kesfet"),
                        ),
                        Positioned(
                          top: height * 0.5,
                          left: width * 0.015,
                          child: Text(
                            "Popüler Testler",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    cardDesingTests(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Popüler Kişiler",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                    ),
                    cardDesingTests(),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget circleImages(String title) {
    return Container(
      height: height * 0.25,
      width: width * 0.4,
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: new AssetImage('assets/$title.png'),
        ),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget cardDesingTests() {
    CarouselSlider carouselSlider = CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int itemIndex) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(colors: [
                  Color(0xff6DC8F3),
                  Color(0xff73A1F9)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff73A1F9),
                    blurRadius: 5,
                    //offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
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
                        "En Sevdiğin Oyun Satranç Mı ?",
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
                          '${itemIndex + 1}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
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
                painter: CustomCardShapePainter(12,
                  Color(0xff6DC8F3),
                  Color(0xff73A1F9),),
              ),
            ),
          ],
        ),
      ),
    );
    return carouselSlider;
  }
}
