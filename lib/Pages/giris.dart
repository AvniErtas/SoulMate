import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Pages/Kategoriler.dart';
import 'package:soulmate/Pages/Kesfet/kesfet_eski.dart';
import 'package:soulmate/Pages/Sonuclar/sonuclarTestler.dart';
import 'package:soulmate/Pages/Sonuclar/sonuclar.dart';
import 'package:soulmate/Pages/login/login_screen.dart';
import 'package:soulmate/Pages/testler.dart';
import 'package:soulmate/Tools/CustomCardShapePainter.dart';
import 'package:soulmate/Widgets/Cards/CardDesingTests.dart';
import 'package:soulmate/Widgets/Cards/CardDesingTests2.dart';
import 'package:soulmate/Widgets/circleCategory.dart';
import 'package:soulmate/Widgets/dataSearch.dart';
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
import 'package:awesome_dialog/awesome_dialog.dart';
import 'Kesfet/kesfet.dart';
import 'evethayir.dart';
import 'login/firebaseauth_provider.dart';

class GirisSayfasi extends StatefulWidget {
  VoidCallback menuStart;

  GirisSayfasi(Key k, this.menuStart) : super(key: k);

  @override
  GirisSayfasiState createState() => GirisSayfasiState();
}

class GirisSayfasiState extends State<GirisSayfasi>
    with SingleTickerProviderStateMixin {
  static List<TargetFocus> targets = List();
  List<TargetPosition> targetsPosition = List();

  static GlobalKey keyButton = GlobalKey();
  static GlobalKey keyButton2 = GlobalKey();
  static GlobalKey keyButton3 = GlobalKey();
  static GlobalKey keyButton4 = GlobalKey();
  static GlobalKey keyButton5 = GlobalKey();

  double width;
  double height;
  Duration myDuration = Duration(seconds: 1);
  AnimationController _controller;
  Animation animation;
  Animation animation2;
  SequenceAnimation siralianimasyon;

  List<Test> testler = new List<Test>();
  AnaSayfaBloc _anaSayfaBloc;

  @override
  void initState() {
    super.initState();
    initTargets();
    //WidgetsBinding.instance.addPostFrameCallback(
      //  _afterLayout); // Yardım ekranın uygulama ilk açıldığında başlatılması
    _controller = AnimationController(
      vsync: this,
      duration: myDuration,
    );
    siralianimasyon = sequenceAnimation();
    _controller.forward();
    _anaSayfaBloc = BlocProvider.of<AnaSayfaBloc>(context);
    _anaSayfaBloc.add(FetchAnaSayfaEvent());
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
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: GradientColors.Background1,
      ),
      child: SingleChildScrollView(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    /*Row(
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
                                onPressed: widget.menuStart,
                              ),
                            ),
                          ),
                        ],
                      ),*/
//                    testisecsonucincelekesfet(),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              key: keyButton,
                              onTap: () {
                                Navigator.pushNamed(context, '/Kategoriler');
                                //Navigator.pushNamed(context, '/OnBoarding');
                              },
                              child: _buildWikiCategory(
                                  Icons.star_border,
                                  "Testini Seç",
                                  Colors.deepPurple.withOpacity(0.8)),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: InkWell(
                              key: keyButton2,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/SonuclarTumTestler');
                              },
                              child: _buildWikiCategory(
                                  Icons.touch_app,
                                  "Sonuçları İncele",
                                  Colors.blue.withOpacity(0.8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              key: keyButton3,
                              onTap: () {
                                Navigator.pushNamed(context, '/Kesfet');
                              },
                              child: _buildWikiCategory(Icons.search, "Keşfet",
                                  Colors.indigo.withOpacity(0.8)),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: InkWell(
                              key: keyButton4,
                              onTap: () {
                                AwesomeDialog(
                                    context: context,
                                    animType: AnimType.LEFTSLIDE,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.INFO,
                                    title: 'Görmek Istediğiniz Testi Seçiniz',
                                    desc: "",
                                    btnOkOnPress: () {
                                      showSearch(context: context, delegate: DataSearch());
//                                      Navigator.of(context).pushNamed('/ArkadasListesiPaylasim');
                                    },
                                    btnCancelOnPress: () {},
                                    btnOkIcon: Icons.check_circle,
                                    btnOkColor: Colors.teal,
                                    btnOkText: "Çözdüğüm Testler",
                                    btnCancelIcon: Icons.details,
                                    btnCancelText: "Test Istekleri",
                                    btnCancelColor: Colors.green,
                                    onDissmissCallback: () {})
                                  ..show();
                              },
                              child: _buildWikiCategory(Icons.person,
                                  "Testlerim", Colors.green.withOpacity(0.8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CategoryChooser(
                      onTap: (category) => Navigator.pushNamed(
                          context, 'category_bikes',
                          arguments: category),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Popüler Testler",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: BlocBuilder<AnaSayfaBloc, AnaSayfaState>(
                          key: keyButton5,
                          bloc: _anaSayfaBloc,
                          builder: (context, AnaSayfaState state) {
                            if (state is AnaSayfaUninitialized) {
                              return Text("UNINIT");
                            } else if (state is AnaSayfaLoading) {
                              return new Center(
                                child: new CircularProgressIndicator(),
                              );
                            } else if (state is AnaSayfaLoaded) {
                              testler = state.Tests[0];
                              List<String> testAdi = new List<String>();
                              for (Test test in state.Tests[0]) {
                                testAdi.add(test.testAdi);
                              }
                              return cardDesingTests2(
                                  testVeSorular: state.Tests[0],
                                  onClick: (itemIndex, id) =>
                                      onClickTest(itemIndex, id));
                            } else if (state is AnaSayfaError) {
                              return Text("İnternet yok amk");
                            } else {
                              return Text("state");
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "En Çok Çözülenler",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                    ),
                    BlocBuilder<AnaSayfaBloc, AnaSayfaState>(
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
                            for (Test test in state.Tests[1]) {
                              testAdi.add(test.testAdi);
                            }
                            return cardDesingTests(
                                testVeSorular: testAdi,
                                onClick: (itemIndex, id) =>
                                    onClickTest(itemIndex, id));
                          } else if (state is AnaSayfaError) {
                            return Text("İnternet yok amk");
                          } else {
                            return Text("state");
                          }
                        }),
//                      profileCardDesign(height * 0.20, width * 0.35),  //Popüler kişiler
                  ],
                ),
              );
            }),
      ),
    );
  }

  Stack _buildWikiCategory(IconData icon, String label, Color color) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(26.0),
          alignment: Alignment.centerRight,
          child: Opacity(
              opacity: 0.3,
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              )),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(height: 16.0),
              Text(
                label,
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Function onClickTest(String soruAdi, String id) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EvetHayirBolumu(soruAdi, id)));
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
            //child: circleImages("testsec"),
            onTap: () {
              /* Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KategoriBolumu()));*/
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProviderwithFirebaseAuth()));
            },
          ),
        ),
        Transform.translate(
          offset: Offset(siralianimasyon["translate2"].value, height * 0.15),
          child: InkWell(
            //child: circleImages("sonucincele"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SonuclarTestler()));
            },
          ),
        ),
        Transform.translate(
          offset: Offset(siralianimasyon["translate3"].value, height * 0.3),
          child: InkWell(
            //child: circleImages("kesfet"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Kesfet()));
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

  /* Widget circleImages(String title) {
    GlobalKey keyButtonCircle = GlobalKey();
    if (title == "testsec")
      keyButtonCircle = keyButton;
    else if (title == "sonucincele")
      keyButtonCircle = keyButton2;
    else
      keyButtonCircle = keyButton3;
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
  }*/

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
                      "Birbirinden farklı kategorilerdeki testlerden sana uygun olanı seç ve bu testleri çözerek kendini ifade et",
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
                    "Çözdüğün testlerin sonuçlarını diğer insanlarla karşılaştır ve uyumunu gör",
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Senin için uygun olan testleri incele ve sana uyumlu kişileri keşfet",
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
    targets.add(
      TargetFocus(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Çözdüğün veya sana gönderilen testlere buradan ulaşabilirsin",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              )),
        ],
        shape: ShapeLightFocus.Circle,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 4",
        keyTarget: keyButton5,
        contents: [
          ContentTarget(
              align: AlignContent.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Popüler testlere ulaşmak için buraya tıklaman yeterli",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              )),
        ],
        shape: ShapeLightFocus.Circle,
      ),
    );
  }

  static void showTutorial() {
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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool isFirst = (prefs.getBool('isFirst') ?? true);
    // if (isFirst) {
    Future.delayed(Duration(milliseconds: 100), () {
      showTutorial();
    });
    // await prefs.setBool('isFirst', false);
    // }

    /* Future.delayed(Duration(milliseconds: 550), () {
      showTutorial();
    });*/
  }

  void testlerimSecim(context) {}

/*void showGifyDialog() {
    showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
          image: Image.network(
            "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF%27s/gif14.gif",
            fit: BoxFit.cover,
          ),
          entryAnimation: EntryAnimation.TOP_LEFT,
          title: Text(""),
          buttonOkText: Text("Çözdüğüm Testler"),
          buttonCancelText: Text("Test İsteklerim"),
          buttonOkColor: Colors.green,
          buttonCancelColor: Colors.red,
          onOkButtonPressed: () {},

        ));
  }*/
}
