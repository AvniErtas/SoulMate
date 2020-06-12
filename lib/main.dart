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
import 'package:soulmate/Pages/Kesfet/kesfet.dart';
import 'package:soulmate/Pages/favoritestlerim.dart';
import 'package:soulmate/Pages/feedback.dart';
import 'package:soulmate/Pages/login/login_screen.dart';
import 'package:soulmate/Pages/notificationPage.dart';
import 'package:soulmate/Pages/paylasmasonrasi.dart';
import 'package:soulmate/Pages/settings_yeni.dart';
import 'package:soulmate/Pages/sorusecme_hazirlama.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/blocs/AnaSayfaBloc/anasayfa_bloc.dart';
import 'package:soulmate/blocs/SonucBloc/bloc.dart';
import 'package:soulmate/blocs/Theme/theme.dart';
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


/*TODO lIST
 TODO 1-AnaSayfadaki 4 butonun renkleri belirlenecek ve Kategorilere bağlantı eklenecek          +
 TODO 2-AnaSayfa Bildirim ikonu yönlendirmesi ayarlanacak                                        +
 TODO 3-AnaSayfa Popüler Testler ve En Çok Çözülenler veri tabanından getirilecek
 TODO 4-Soru Hazırla Sayfası  yönlendirme ikonları değiştirilecek                                +
 TODO 5-Mesaj Sayfası ayarlanacak                                                                -
 TODO 6-Profil sayfası profil resmi değiştirme butonları aktif hale getirilecek                  -
 TODO 7-Scaffold altındaki renk belirlenecek                                                     -
 TODO 8-Favorilerime ekle,daha sonra çöz , paylaş butonları aktif hale getirilecek               +
 TODO 9-Sonuçları incele sayfası açılan menü düzenlenecek
 TODO 10-Keşfet sayfası açılan menü düzenlenecek
 TODO 11-Yan Menü Bildirim kaldırılacak
 TODO 12-Profil bölümü arkadaş ekle ve mesaj gönder butonları aktif hale getirilecek
*/

void main() {
//  ClassBuilder.registerClasses();
  setupLocator();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
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
        child: MaterialAppWithTheme(context),
      ),
    );
  }

  MaterialApp MaterialAppWithTheme(context) {
    
   // final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: theme.getTheme(),
        /*theme: ThemeData(
            primarySwatch: Colors.blue,
          ),*/
        routes: {
          '/Kategoriler' : (context) => KategoriBolumu(),
          '/SonuclarTumTestler' : (context) => SonuclarTestler(),
          '/PaylasmaBolumu' : (context) => PaylasmaBolumu(),
          '/PaylasmaSonrasi' : (context) => PaylasmaSonrasi(),
          '/Ayarlar' : (context) => SettingsOnePage(),
          '/Login' : (context) => LoginScreen(),
          '/Kesfet' : (context) => Kesfet(),
          '/Bildirimler' : (context) =>NotificationPage(),
          '/GeriBildirim' : (context) => FeedBack(),
          '/PaylasmaBolumu' : (context) => PaylasmaBolumu(),
          '/FavoriTestlerim' : (context) => FavoriTestlerim(),
        },
        home: MainWidget(),
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
  var keySoruHazirlama = PageStorageKey("key_soruhazirlama");

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
  var userRepo;

  @override
  void initState() {
    super.initState();
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
    userRepo = Provider.of<UserRepository>(context);
    Size size = MediaQuery.of(context).size;

    setState(() {
      screenHeight = size.height;
      screenWidth = size.width;
    });


    return SafeArea(
      child: Scaffold(
        appBar: selectedIndex == 1 ? null : appBarTasarim2(title: "Test App",context: context),
        drawer: DrawerPage(onPageChange: (index) {
          pageChanger(index);
        },),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: bottomBarDesign(),
        body: IndexedStack(
          index: selectedIndex,
          children: <Widget>[
            GirisSayfasi(keyAnaSayfa,menuStart),
            FavoriTestlerim(),
            HomeScreen(),
            UserProfilePage(keyProfile,returnMainWidget),
            SettingsOnePage(),
          ],
        )
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
  Function onClickAyarlar(){
    Navigator.pushReplacementNamed(context, '/Ayarlar');
  }
  bottomBarDesign() {
    return CurvedNavigationBar(
      index: selectedIndex,
      height: 50.0,
      items: <Widget>[
        Icon(Icons.home, size: 30,color: Colors.white,),
        Icon(Icons.favorite, size: 30,color: Colors.white,),
        Icon(Icons.email, size: 30,color: Colors.white,),
        Icon(Icons.account_circle, size: 30,color: Colors.white,),
      ],
      color: Colors.indigo,
      buttonBackgroundColor: Colors.indigo,
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        //if(userRepo.durum == UserDurumu.OturumAcik)
        setState(() {
          selectedIndex = index;
        });
        //else Navigator.pushNamed(context, '/Login');
      },
    );
  }

  Function returnMainWidget() {
    setState(() {
      selectedIndex = 0;
    });
  }

  Function pageChanger  (int index) {
    debugPrint('girdi$index');
    setState(() {
      selectedIndex = index;
    });
  }
}