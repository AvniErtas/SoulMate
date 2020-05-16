import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Tools/CustomCardShapePainter.dart';
import 'package:soulmate/Widgets/Cards/CardDesingTests.dart';
import 'package:soulmate/model/paylasilan.dart';
import 'package:soulmate/model/paylasim.dart';
import 'package:soulmate/model/test.dart';

class EvetHayirBolumu extends StatefulWidget {
  String testAdi;
  EvetHayirBolumu(this.testAdi);

  @override
  _EvetHayirBolumuState createState() => _EvetHayirBolumuState();
}

class _EvetHayirBolumuState extends State<EvetHayirBolumu>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  int _current = 0;
  int soruNo = 0;
  double rating = 50;
  List<int> siklar = new List<int>(5);
  List<Border> border = new List<Border>(4);
  double heightMedia;
  double widthMedia;
  List<double> animatedContainerSize = new List<double>(2);
  List<int> soru_tipler = new List<int>(5);
  CarouselSlider carouselSlider;
  List<Test> testler = new List<Test>();

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

    soru_tipler[0] = 0;
    soru_tipler[1] = 0;
    soru_tipler[2] = 1;
    soru_tipler[3] = 2;
    soru_tipler[4] = 2;

    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorusudur 1 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorusudur 2 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorusudur 3 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorusudur 4 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorusudur 5 ???'));
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
      appBar: AppBar(title: Text(widget.testAdi),),
      backgroundColor: animation.value,
      body: Container(
        child: testevethayirBolumu(),
      ),
    );
  }

  Widget testevethayirBolumu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buttonDemo(),
       soruSecimleri(soru_tipler[soruNo]),
        bitir_buton(),
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

                carouselSlider.nextPage(
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
       return  abcdSiklari();
//    altProfilBolumu(),
        break;
      case 2:
        return sliderTasarim();
        break;
    }
  }
  Widget buttonDemo() {
    carouselSlider = cardDesingTests(testler: testler,pageChanged: (index) {
      onPageChanged(index);
    });

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
                  height: MediaQuery.of(context).size.height * 0.050,
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
//                  setState(() {
//                    index++;
//                  });
                  carouselSlider.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.050,
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

  Function onPageChanged(int index){
    setState(() {
//          this.soruNo = soru_tipler[index];
      soruNo = index;
      animatedContainerSize[0] = 100.0;
      animatedContainerSize[1] = 100.0;
      if (siklar[index] != null) {
        if(soru_tipler[index]==0)
          animatedContainerSize[siklar[index]] = 150.0;
        if(soru_tipler[index]==1)
          border[siklar[index]] = Border.all(width: 5);
        debugPrint(siklar[index].toString());
      }

    });
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
            "${siklar[soruNo] != null ? siklar[soruNo].toInt() : 50}",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        Slider(
          value: siklar[soruNo] != null ? siklar[soruNo].toDouble() : 50.0,
          min: 0,
          max: 100,
          //label: "${rating.toInt()}",
          activeColor: Colors.pink,
          divisions: 100,
          inactiveColor: Colors.white,
          onChanged: (newRating) {
            setState(() {
              siklar[soruNo] = newRating.toInt();
            });
          },
        ),
      ],
    );
  }
  Widget abcdSiklari() {
    return ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
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
                  border: /*border[soruNo] == null ? null : Border.all(width: 5) ,*/ border[index],
                ),
                child: Center(
                    child: Text(
                      "Bu bir şıktır",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
          );
        });
  }

  Widget bitir_buton() {
    bool hasNull = false;
   return Align(
     alignment: Alignment.centerRight,
     child: Padding(
       padding: const EdgeInsets.only(right: 10),
       child: ButtonTheme(
          height: 25.0,
          child: FlatButton(
            onPressed: () => {
              siklar.forEach((element) {
                if(element == null)
                  hasNull = true;
              }),
             if(hasNull)
               showEmptyDialog()
              else showBitirmeDialog()

            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            color: Colors.green,
            child: Row(
              // Replace with a Row for horizontal icon + text
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 6),
                  child: Icon(
                    Icons.done,
                    size: 15,
                  ),
                ),
                Text(
                  "Bitir",
                  style: TextStyle(fontSize: 11),
                )
              ],
            ),
          ),
        ),
     ),
   );
  }

  showEmptyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Tüm cevapları işaretleyiniz!"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  showBitirmeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Testi bitirmek istiyor musunuz?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Hayır"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Evet"),
              onPressed: () {
                // TODO paylasilan objesini sunucuya kaydet path= /paylasim/cevapEkle
                Paylasilan paylasilan = new Paylasilan("paylasimID", "paylasilanUid", siklar);
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }
}

