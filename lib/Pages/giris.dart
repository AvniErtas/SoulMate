import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Pages/Kategoriler.dart';
import 'package:soulmate/Pages/Kesfet/kesfet_eski.dart';
import 'package:soulmate/Pages/Sonuclar/sonuclarTestler.dart';
import 'package:soulmate/Pages/Sonuclar/sonuclar.dart';
import 'package:soulmate/Pages/testler.dart';
import 'package:soulmate/Tools/CustomCardShapePainter.dart';
import 'package:soulmate/Widgets/Cards/CardDesingTests.dart';
import 'package:soulmate/blocs/AnaSayfaBloc/anasayfa_bloc.dart';
import 'package:soulmate/blocs/AnaSayfaBloc/anasayfa_event.dart';
import 'package:soulmate/blocs/AnaSayfaBloc/anasayfa_state.dart';
import 'package:soulmate/blocs/TestBloc/bloc.dart';
import 'package:soulmate/model/test.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/content_target.dart';
import 'package:tutorial_coach_mark/target_focus.dart';
import 'package:tutorial_coach_mark/target_position.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'Kesfet/kesfet.dart';
import 'evethayir.dart';

class GirisSayfasi extends KFDrawerContent {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi>
    with SingleTickerProviderStateMixin {
  List<TargetFocus> targets = List();
  List<TargetPosition> targetsPosition = List();

  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();

  double width;
  double height;
  Duration myDuration = Duration(seconds: 1);
  AnimationController _controller;
  Animation animation;
  Animation animation2;
  SequenceAnimation siralianimasyon;

  List<Test> testler = new List<Test>();

  @override
  void initState() {
    super.initState();
    initTargets();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout); // Yardım ekranın uygulama ilk açıldığında başlatılması
    _controller = AnimationController(
      vsync: this,
      duration: myDuration,
    );
    siralianimasyon = sequenceAnimation();
    _controller.forward();

    testler.add(new Test(
        id: '123',
        olusturanUid: '124',
        olusturanTipi: 'Ekip',
        kategori: 'Aşk',
        olusturmaTarihi: 11111,
        testAdi: 'Bu bir test başlığıdır 1 ???'));
    testler.add(new Test(
        id: '123',
        olusturanUid: '124',
        olusturanTipi: 'Ekip',
        kategori: 'Aşk',
        olusturmaTarihi: 11111,
        testAdi: 'Bu bir test sorusudur 2 ???'));
    testler.add(new Test(
        id: '123',
        olusturanUid: '124',
        olusturanTipi: 'Ekip',
        kategori: 'Aşk',
        olusturmaTarihi: 11111,
        testAdi: 'Bu bir test sorusudur 3 ???'));
    testler.add(new Test(
        id: '123',
        olusturanUid: '124',
        olusturanTipi: 'Ekip',
        kategori: 'Aşk',
        olusturmaTarihi: 11111,
        testAdi: 'Bu bir test sorusudur 4 ???'));
    testler.add(new Test(
        id: '123',
        olusturanUid: '124',
        olusturanTipi: 'Ekip',
        kategori: 'Aşk',
        olusturmaTarihi: 11111,
        testAdi: 'Bu bir test sorusudur 5 ???'));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _anaSayfaBloc = BlocProvider.of<AnaSayfaBloc>(context);
    _anaSayfaBloc.add(FetchAnaSayfaEvent());

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
                                  color: Colors.white,
                                ),
                                onPressed: widget.onMenuPressed,
                              ),
                            ),
                          ),
                        ],
                      ),
                      testisecsonucincelekesfet(),
                      BlocBuilder<AnaSayfaBloc,AnaSayfaState>(
                        key: keyButton4,
                          bloc: _anaSayfaBloc,
                          builder: (context, AnaSayfaState state) {
                            if (state is AnaSayfaUninitialized) {
                              return Text("UNINIT");
                            } else if (state is AnaSayfaLoading) {
                              return new Center(
                                child: new CircularProgressIndicator(),
                              );
                            } else if (state is AnaSayfaLoaded) {
                              List<String> testAdi = new List<String>();
                              for(Test test in  state.Tests[0]){
                                testAdi.add(test.testAdi);
                              }
                              return cardDesingTests(
                                  testVeSorular: testAdi,
                                  onClick: (itemIndex) =>
                                      onClickTest(itemIndex));
                            } else if (state is AnaSayfaError) {
                              return Text("İnternet yok amk");
                            }else {

                              return Text("state");
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "En Çok Çözülenler",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                      BlocBuilder<AnaSayfaBloc,AnaSayfaState>(
                          bloc: _anaSayfaBloc,
                          builder: (context, AnaSayfaState state) {
                            if (state is AnaSayfaUninitialized) {
                              return Text("UNINIT");
                            } else if (state is AnaSayfaLoading) {
                              return new Center(
                                child: new CircularProgressIndicator(),
                              );
                            } else if (state is AnaSayfaLoaded) {
                              List<String> testAdi = new List<String>();
                              for(Test test in  state.Tests[1]){
                                testAdi.add(test.testAdi);
                              }
                              return cardDesingTests(
                                  testVeSorular: testAdi,
                                  onClick: (itemIndex) =>
                                      onClickTest(itemIndex));
                            } else if (state is AnaSayfaError) {
                              return Text("İnternet yok amk");
                            }else {

                              return Text("state");
                            }
                          }),
//                      profileCardDesign(height * 0.20, width * 0.35),  //Popüler kişiler

                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Function onClickTest(int secilenSoru) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EvetHayirBolumu(testler[secilenSoru].testAdi)));
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
                  MaterialPageRoute(builder: (context) => SonuclarTestler()));
            },
          ),
        ),
        Transform.translate(
          offset: Offset(siralianimasyon["translate3"].value, height * 0.3),
          child: InkWell(
            child: circleImages("kesfet"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Kesfet()));
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
    GlobalKey keyButtonCircle = GlobalKey();
    if(title=="testsec")
      keyButtonCircle = keyButton;
    else if(title=="sonucincele")
      keyButtonCircle = keyButton2;
    else keyButtonCircle = keyButton3;
    return Container(
      key: keyButtonCircle,
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

  void initTargets() {
    targets.add(TargetFocus(
      //target 1
      identify: "Target 1",
      keyTarget: keyButton,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Nasılım ? \n ",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Bir çok konuda fikir almak çok kolay,fikir almak istediğin bölümü seç, uzman ekibimize veya arkadaşlarına danış",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      //target 2
      identify: "Target 2",
      keyTarget: keyButton2,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Giyim konusunda danışmak ister misin?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )),
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      //target 2
      identify: "Target 2ek",
      keyTarget: keyButton3,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Satın almak istediğin ürün ile ilgili görüşe mi ihtiyacın var ?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Sana uygun kategoriyi seçip hemen fikir alabilirsin",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )),
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      identify: "Target 4",
      keyTarget: keyButton4,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Satın almak istediğin ürün ile ilgili görüşe mi ihtiyacın var ?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Sana uygun kategoriyi seçip hemen fikir alabilirsin",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )),
      ],
      shape: ShapeLightFocus.Circle,
    ));
  }
  void showTutorial() {
    //yardım ekranı başlaması için bu fonksiyon çağırılıyor
    TutorialCoachMark(keyButton.currentContext,
        targets: targets,
        colorShadow: Colors.transparent,
        textSkip: "BİTİR",
        paddingFocus: 2,
        opacityShadow: 0.8, finish: () {
          print("finish");
        }, clickTarget: (target) {
          print(target);
        }, clickSkip: () {
          print("skip");
        })
      ..show();
  }
  void _afterLayout(_) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirst = (prefs.getBool('isFirst') ?? true);
    if(isFirst) {
      Future.delayed(Duration(milliseconds: 100), () {
        showTutorial();
      });
      await prefs.setBool('isFirst', false);
    }
    /*Future.delayed(Duration(milliseconds: 550), () {
      showTutorial();
    });*/
  }
}
