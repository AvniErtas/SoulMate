import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider/provider.dart';
import 'package:soulmate/Pages/Drawer/auto.dart';
import 'package:soulmate/Pages/Drawer/calendar.dart';
import 'package:soulmate/Pages/Drawer/class.dart';
import 'package:soulmate/Pages/Kategoriler.dart';
import 'package:soulmate/Pages/paylasmasonrasi.dart';
import 'package:soulmate/Pages/settings_yeni.dart';
import 'package:soulmate/Pages/sorusecme_hazirlama.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/blocs/AnaSayfaBloc/anasayfa_bloc.dart';
import 'package:soulmate/blocs/SonucBloc/bloc.dart';
import 'package:soulmate/blocs/locator.dart';
import 'package:soulmate/data/user_repository.dart';
import 'Pages/Drawer/home.dart';
import 'Pages/Sonuclar/sonuclar.dart';
import 'Pages/Sonuclar/sonuclarTestler.dart';
import 'Pages/animatedPage.dart';
import 'Pages/giris.dart';
import 'Pages/paylasmabolumu.dart';
import 'Pages/profile.dart';
import 'Widgets/drawer.dart';
import 'blocs/TestBloc/test_bloc.dart';

void main() {
//  ClassBuilder.registerClasses();
  setupLocator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AnaSayfaBloc>(
          create: (BuildContext context) => AnaSayfaBloc(),
        ),
        BlocProvider<TestBloc>(
          create: (BuildContext context) => TestBloc(),
        ),
        BlocProvider<SonucBloc>(
          create: (BuildContext context) => SonucBloc(),
        ),

      ],
      child: ChangeNotifierProvider<UserRepository>(
        create: (context) => UserRepository(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/Kategoriler' : (context) => KategoriBolumu(),
            '/SonuclarTumTestler' : (context) => SonuclarTestler(),
            '/PaylasmaBolumu' : (context) => PaylasmaBolumu(),
            '/PaylasmaSonrasi' : (context) => PaylasmaSonrasi(),
            '/Ayarlar' : (context) => SettingsOnePage(),
            '/SoruHazirlama' : (context) => SoruSecmeVeHazirlama(),

          },
          home: MainWidget(),
        ),
      ),
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
  var keyAnaSayfa = PageStorageKey("key_anasayfa");
  var keyProfile = PageStorageKey("key_profile");
  final PageStorageBucket _bucket = new PageStorageBucket();
  KFDrawerController _drawerController;
  List<Widget> tumSayfalar;
  int selectedIndex = 0;

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 500);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;


  @override
  void initState() {
    super.initState();
    tumSayfalar = [
      GirisSayfasi(keyAnaSayfa,menuStart),
      SoruSecmeVeHazirlama(),
      HomeScreen(),
      UserProfilePage(keyProfile,returnMainWidget),
      SettingsOnePage(),
    ];
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
    
  //  _drawerController = drawerController();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    setState(() {
      screenHeight = size.height;
      screenWidth = size.width;
    });


    return SafeArea(
      child: Scaffold(
        appBar: appBarTasarim2("Test App"),
        drawer: DrawerPage(onPageChange: (index) {
          pageChanger(index);
        },),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: bottomBarDesign(),
        body: tumSayfalar[selectedIndex]
      ),
    );
//    MenuDashboard();
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Dashboard", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Messages", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Utility Bills", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Funds Transfer", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Branches", style: TextStyle(color: Colors.white, fontSize: 22)),
              ],
            ),
          ),
        ),
      ),
    );
  }
  VoidCallback menuStart() {
    setState(() {
      if (isCollapsed)
        _controller.forward();
      else
        _controller.reverse();

      isCollapsed = !isCollapsed;
    });

}
//  Widget drawer() {
//    return KFDrawer(
//    items: listss(),
////        borderRadius: 0.0,
////        shadowBorderRadius: 0.0,
////        menuPadding: EdgeInsets.all(0.0),
////        scrollable: true,
//      controller: drawerController(),
//     /* header: Align(
//        alignment: Alignment.bottomCenter,
//        child: Container(
//          padding: EdgeInsets.symmetric(horizontal: 16.0),
//          width: MediaQuery.of(context).size.width * 0.3,
//          child: Image.asset(
//            'assets/logo.png',
//            alignment: Alignment.centerLeft,
//          ),
//        ),
//      ),*/
//      footer: KFDrawerItem(
//        text: Text(
//          'GİRİŞ YAP',
//          style: TextStyle(color: Colors.white),
//        ),
//        icon: Icon(
//          Icons.input,
//          color: Colors.white,
//        ),
//        onPressed: () {
//          Navigator.of(context).push(CupertinoPageRoute(
//            fullscreenDialog: true,
//            builder: (BuildContext context) {
//              return AuthPage();
//            },
//          ));
//        },
//      ),
//      decoration: BoxDecoration(
//        gradient: LinearGradient(
//          begin: Alignment.topLeft,
//          end: Alignment.bottomRight,
//          colors: [Colors.greenAccent, Colors.indigo],
//          tileMode: TileMode.repeated,
//        ),
//      ),
//    );
//  }
  List<KFDrawerItem> listss() {
    List<KFDrawerItem> list = new List<KFDrawerItem>();
    list.add(KFDrawerItem(
      text: Text(
        'GİRİŞ YAP',
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
    ),);
  }
//  KFDrawerController drawerController() {
//    return  KFDrawerController(
//
//      initialPage: ClassBuilder.fromString(tumSayfalar[selectedIndex]),
//      items: [
//        KFDrawerItem.initWithPage(
//          text: Text('ANASAYFA', style: TextStyle(color: Colors.white)),
//          icon: Icon(Icons.home, color: Colors.white),
////          page: GirisSayfasi(),
//        ),
//        KFDrawerItem.initWithPage(
//          text: Text(
//            'SORU HAZIRLA',
//            style: TextStyle(color: Colors.white),
//          ),
//          icon: Icon(Icons.add_circle_outline, color: Colors.white),
//          page: SoruSecmeVeHazirlama(),
//        ),
//        KFDrawerItem.initWithPage(
//          text: Text(
//            'BİLDİRİMLER',
//            style: TextStyle(color: Colors.white),
//          ),
//          icon: Icon(Icons.notifications_active, color: Colors.white),
//          page: SoruSecmeVeHazirlama(),
//        ),
//        KFDrawerItem.initWithPage(
//          text: Text(
//            'MESAJLAR',
//            style: TextStyle(color: Colors.white),
//          ),
//          icon: Icon(Icons.message, color: Colors.white),
//          page: SoruSecmeVeHazirlama(),
//        ),
//        KFDrawerItem.initWithPage(
//          text: Text(
//            'YARDIM',
//            style: TextStyle(color: Colors.white),
//          ),
//          icon: Icon(Icons.help, color: Colors.white),
////         page: GirisSayfasi(),
//          onPressed: () {
//            Navigator.pop(context);
//            GirisSayfasiState.showTutorial();
//          },
//
//        ),
//        KFDrawerItem.initWithPage(
//          text: Text(
//            'AYARLAR',
//            style: TextStyle(color: Colors.white),
//          ),
//          icon: Icon(Icons.settings, color: Colors.white),
//          page: ClassBuilder.fromString('SettingsOnePage'),
//
//        ),
//      ],
//    );
//  }
  Function onClickAyarlar(){
    Navigator.pushReplacementNamed(context, '/Ayarlar');
  }
  bottomBarDesign() {
    return CurvedNavigationBar(
      index: selectedIndex,
      height: 50.0,
      items: <Widget>[
        Icon(Icons.home, size: 30,color: Colors.white,),
        Icon(Icons.add_circle, size: 30,color: Colors.white,),
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

  Function returnMainWidget() {
    setState(() {
      selectedIndex = 1;
    });
  }

  Function pageChanger  (int index) {
    debugPrint('girdi$index');
    setState(() {
      selectedIndex = index;
    });
  }
}