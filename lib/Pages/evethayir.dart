import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Tools/CustomCardShapePainter.dart';

class EvetHayirBolumu extends StatefulWidget {
  @override
  _EvetHayirBolumuState createState() => _EvetHayirBolumuState();
}

class _EvetHayirBolumuState extends State<EvetHayirBolumu>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  int index=0;
  int _current = 0;
  int soruNo = 0;
  double rating = 50;
  List<int> siklar = new List<int>(5);
  List<Border> border = new List<Border>(4);
  double heightMedia;
  double widthMedia;
  List<double> animatedContainerSize = new List<double>(2);

  CarouselSlider carouselSlider;

  @override
  void initState() {
    animatedContainerSize[0] = 100.0;
    animatedContainerSize[1] = 100.0;

    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = ColorTween(begin: Colors.white, end: Colors.lightBlueAccent)
        .animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
    _controller.addStatusListener(
      (durum) {
        if (durum == AnimationStatus.completed) {
          _controller.reverse().orCancel;
        } else if (durum == AnimationStatus.dismissed) {
          _controller.forward().orCancel; //sonsuza kadar devam edebilir.
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    heightMedia = MediaQuery.of(context).size.height;
    widthMedia = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: animation.value,
      body: SingleChildScrollView(
        child: Container(
          child: testevethayirBolumu(),
        ),
      ),
    );
  }

  Widget testevethayirBolumu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buttonDemo(),
       soruSecimleri(index),
      ],
    );
  }
  Widget soruSecimleri(int index) {
    switch(index) {
      case 0:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  siklar[soruNo] = 0;
                  animatedContainerSize[0] = 150.0;
                });
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    animatedContainerSize[0] = 100.0;
                  });
                });

                carouselSlider.nextPage(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.linear);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.fastLinearToSlowEaseIn,
                height: animatedContainerSize[0],
                width: animatedContainerSize[0],
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  //       border: border[0],
                  image: DecorationImage(
                    image: AssetImage("images/digericonlar/evet.png"),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  siklar[soruNo] = 1;
                  animatedContainerSize[1] = 150;
                });
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    animatedContainerSize[1] = 100;
                  });
                });

                carouselSlider.previousPage(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.linear);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.fastLinearToSlowEaseIn,
                height: animatedContainerSize[1],
                width: animatedContainerSize[1],
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/digericonlar/hayir.png"),
                  ),
                ),
              ),
            ),
          ],
        );
        break;
      case 1:
       return  sliderTasarim();
//    altProfilBolumu(),
        break;
      case 2:
        return abcdSiklari();
        break;
    }
  }
  Widget buttonDemo() {
    carouselSlider = CarouselSlider.builder(
      itemCount: 5,
      onPageChanged: (index) {
        setState(() {
          soruNo = index;
          animatedContainerSize[0] = 100.0;
          animatedContainerSize[1] = 100.0;
          if (siklar[index] != null) {
            animatedContainerSize[siklar[index]] = 150.0;
          }
        });
      },
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

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          carouselSlider,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
              child: InkWell(
                onTap: () {
                  carouselSlider.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.075,
                  width: MediaQuery.of(context).size.width * 0.25,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/digericonlar/onceki.png"),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    index++;
                  });
                  carouselSlider.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.075,
                  width: MediaQuery.of(context).size.width * 0.25,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/digericonlar/sonraki.png"),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ]);
  }
  Widget sliderTasarim() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            color: siklar[soruNo]==null ? Colors.indigo : Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Text(
            "${rating.toInt()}",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        Slider(
          value: rating,
          min: 0,
          max: 100,
          //label: "${rating.toInt()}",
          activeColor: Colors.pink,
          divisions: 100,
          inactiveColor: Colors.white,
          onChanged: (newRating) {
            setState(() {
              rating = newRating;
              siklar[soruNo] = newRating.toInt();
            });
          },
        ),
      ],
    );
  }
  Widget abcdSiklari() {
    return SizedBox(
      height: heightMedia * 0.4,
      child: ListView.builder(
          itemCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Material(
              color: Colors.white.withOpacity(0.0),
              child: InkWell(
                onTap: () => {
                  this.setState(() {
                    siklar[soruNo] = index;

                    for (int i = 0; i < border.length; i++) {
                      if (i != index) border[i] = null;
                    }
                    border[index] = Border.all(width: 5);
                    carouselSlider.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear);
                    Future.delayed(const Duration(milliseconds: 500), () {
                      setState(() {
                        border[index] = null;
                      });
                    });
                  })
                },
                child: Container(

                  height: heightMedia * 0.075,
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  decoration: BoxDecoration(
                    /* gradient: renkler[index + 12].gradient, */
                    gradient: GradientColors.purplewhite,
                    borderRadius: BorderRadius.circular(15.0),
                    border: border[index],
                  ),
                  child: Center(
                      child: Text(
                        "Bu bir şıktır",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            );
          }),
    );
  }
}

