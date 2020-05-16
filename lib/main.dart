import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:soulmate/Pages/Drawer/auto.dart';
import 'package:soulmate/Pages/Drawer/calendar.dart';
import 'package:soulmate/Pages/Drawer/class.dart';
import 'package:soulmate/Pages/sorusecme_hazirlama.dart';
import 'package:soulmate/blocs/locator.dart';
import 'Pages/giris.dart';
import 'blocs/test_bloc.dart';

void main() {
  ClassBuilder.registerClasses();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<TestBloc>(
          create: (context)=>TestBloc(),
          child: MainWidget()),
    );
  }
}

class MainWidget extends StatefulWidget {
  MainWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  KFDrawerController _drawerController;
  List<String> tumSayfalar;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    tumSayfalar = [
      "GirisSayfasi",
      "CalendarPage",
      "SettingsOnePage",
      "UserProfilePage",
    ];
  //  _drawerController = drawerController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBarDesign(),
      body: drawer(),
    );
  }

  Widget drawer() {
    return KFDrawer(

//        borderRadius: 0.0,
//        shadowBorderRadius: 0.0,
//        menuPadding: EdgeInsets.all(0.0),
//        scrollable: true,
      controller: drawerController(),
      header: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          width: MediaQuery.of(context).size.width * 0.6,
          child: Image.asset(
            'assets/logo.png',
            alignment: Alignment.centerLeft,
          ),
        ),
      ),
      footer: KFDrawerItem(
        text: Text(
          'SIGN IN',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.input,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return AuthPage();
            },
          ));
        },
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromRGBO(255, 255, 255, 1.0), Color.fromRGBO(44, 72, 171, 1.0)],
          tileMode: TileMode.repeated,
        ),
      ),
    );
  }
  KFDrawerController drawerController() {
    return  KFDrawerController(

      initialPage: ClassBuilder.fromString(tumSayfalar[selectedIndex]),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('ANASAYFA', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.home, color: Colors.white),
          page: GirisSayfasi(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'SORU HAZIRLA',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.calendar_today, color: Colors.white),
          page: SoruSecmeVeHazirlama(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'AYARLAR',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.settings, color: Colors.white),
          page: ClassBuilder.fromString('SettingsOnePage'),
        ),
      ],
    );
  }
  bottomBarDesign() {
    return CurvedNavigationBar(
      index: selectedIndex,
      height: 50.0,
      items: <Widget>[
        Icon(Icons.home, size: 30,color: Colors.white,),
        Icon(Icons.send, size: 30,color: Colors.white,),
        Icon(Icons.message, size: 30,color: Colors.white,),
        Icon(Icons.account_circle, size: 30,color: Colors.white,),
      ],
      color: Colors.indigo,
      buttonBackgroundColor: Colors.indigo,
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}