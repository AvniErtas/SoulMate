import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Pages/Kategoriler.dart';
import 'package:soulmate/Pages/Kesfet/kesfet.dart';
import 'package:soulmate/Pages/sonuc_inceleme.dart';
import 'package:soulmate/Pages/testler.dart';
import 'package:soulmate/Tools/CustomCardShapePainter.dart';
import 'package:soulmate/Widgets/Cards/CardDesingTests.dart';

class GirisSayfasi extends KFDrawerContent {
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
    siralianimasyon = sequenceAnimation();
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
      body: SingleChildScrollView(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: GradientColors.Background1,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
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
                      testisecsonucincelekesfet(),
                      cardDesingTests(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Popüler Kişiler",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                      profileCardDesign(height * 0.20, width * 0.35),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  SequenceAnimation sequenceAnimation() {
    return SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: -200, end: 200), // Opacity için
            from: Duration.zero,
            to: Duration(milliseconds: 500),
            tag: "translate1")
        .addAnimatable(
            animatable: Tween<double>(begin: 400, end: 5),
            from: Duration(milliseconds: 500),
            to: Duration(milliseconds: 1000),
            tag: "translate2")
        .addAnimatable(
            animatable: Tween<double>(begin: -200, end: 200),
            from: Duration(milliseconds: 1000),
            to: Duration(milliseconds: 1500),
            tag: "translate3")
        .animate(_controller);
  }

  Widget testisecsonucincelekesfet() {
    return Stack(
      children: <Widget>[
        Container(
          width: width,
          height: height * 0.55,
        ),
        Transform.translate(
          offset: Offset(siralianimasyon["translate1"].value, 0),
          child: InkWell(
            child: circleImages("testsec"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KategoriBolumu()));
            },
          ),
        ),
        Transform.translate(
          offset: Offset(siralianimasyon["translate2"].value, height * 0.15),
          child: InkWell(
            child: circleImages("sonucincele"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SonucInceleme()));
            },
          ),
        ),
        Transform.translate(
          offset: Offset(siralianimasyon["translate3"].value, height * 0.3),
          child: InkWell(
            child: circleImages("kesfet"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Testler(true)));
            },
          ),
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
}
