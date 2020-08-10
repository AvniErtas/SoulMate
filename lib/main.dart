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
import 'package:soulmate/Pages/feedback.dart';
import 'package:soulmate/Pages/login/login_screen.dart';
import 'package:soulmate/Pages/notificationPage.dart';
import 'package:soulmate/Pages/paylasmasonrasi.dart';
import 'package:soulmate/Pages/settings_yeni.dart';
import 'package:soulmate/Pages/sorusecme_hazirlama.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/blocs/AnaSayfaBloc/anasayfa_bloc.dart';
import 'package:soulmate/blocs/NotificationsBloc/notifications_bloc.dart';
import 'package:soulmate/blocs/ProfileBloc/bloc.dart';
import 'package:soulmate/blocs/SonucBloc/bloc.dart';
import 'package:soulmate/blocs/UserSearchBloc/bloc.dart';
import 'package:soulmate/blocs/locator.dart';
import 'package:soulmate/data/user_repository.dart';
import 'Pages/Drawer/home.dart';
import 'Pages/Sonuclar/sonuclar.dart';
import 'Pages/Sonuclar/sonuclarTestler.dart';
import 'Pages/animatedPage.dart';
import 'Pages/giris.dart';
import 'Pages/paylasmabolumu.dart';
import 'Pages/profile.dart';
import 'Pages/testlerim/cozdugum_testler.dart';
import 'Widgets/drawer.dart';
import 'blocs/TestBloc/test_bloc.dart';

/*TODO lIST
 TODO 1-Bildirim ekranında basılı tutunca silme ekranı gelsin
 TODO 2-test çözüldüyse bildirim kalksın, profil fotosu gelsin
 TODO 3-Testini seç kategoriler ekranı; favorilere ekle yapılacak, alt taraf düzeltilecek, testler veritabanından çekilecek
 TODO 4-Sonuç incele ekranı veritabanından çekilecek, gönderilen testleri çözen kişilerin sonuçları getirilecek, paylaş butonu kalsın sadece
 TODO 5-Keşfet ekranında kendimizin belirlediği testler veritabından getirilecek ve kategori işlemleri gerçekletirilecek
 TODO 6-Profil sayfası profil resmi değiştirme butonları aktif hale getirilecek
 TODO 7-Çözdüğüm testler veritabanından getirilecek(test id'ye göre),filtreleme bölümü ve favorilere ekle iptal edilecek
 TODO 8-Test istekleri ekranı oluşturulacak, gelen test istekleri veritabanındaki kullanıcının bildirimler listesinde "kisiylePaylas" kodundan çekilecek
 TODO 9-Soru hazırlama bitir dendiğinde veritabanına kaydedilecek
 TODO 10-Profil ekranında fotoğraf değiştirme ve isim değiştirme yapılacak,son çözülen testler getirilecek (5 tane)
 TODO 11-Geri bildirim, veritabanına kaydedilsin
 TODO 12-Yardım ekranı sadece anasayfada gösterilecek,bunun için index kontrolü yapacağız
 TODO 13-Nodejs ile mesajlaşma kısmı araştırlacak
 TODO 14-Login ekranındaki hatalar düzeltilecek,google ve facebook girişi aktif edilecek
 TODO 15-Paylaşma sonrası öneri sayfası oluşturulacak
 TODO 16-Çoklu paylaşma ekranı yapılacak

*/

void main() {
//  ClassBuilder.registerClasses();
  setupLocator();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
        BlocProvider<UserSearchBloc>(
          create: (BuildContext context) => UserSearchBloc(),
        ),
        BlocProvider<NotificationsBloc>(
          create: (BuildContext context) => NotificationsBloc(),
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
            '/Kategoriler': (context) => KategoriBolumu(),
            '/SonuclarTumTestler': (context) => SonuclarTestler(),
            '/PaylasmaBolumu': (context) => PaylasmaBolumu(),
            '/PaylasmaSonrasi': (context) => PaylasmaSonrasi(),
            '/Ayarlar': (context) => SettingsOnePage(),
            '/Login': (context) => LoginScreen(),
            '/Kesfet': (context) => Kesfet(),
            '/Bildirimler': (context) => NotificationPage(),
            '/GeriBildirim': (context) => FeedBack(),
            '/CozdugumTestler': (context) => CozdugumTestler(),
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
  var keySoruHazirlama = PageStorageKey("key_soruhazirlama");

  var keyProfile = PageStorageKey("key_profile");
  final PageStorageBucket _bucket = new PageStorageBucket();
  KFDrawerController _drawerController;
  int selectedIndex = 0;

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 500);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  UserRepository userRepo;
  String uid;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);

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
          appBar: selectedIndex == 1
              ? null
              : appBarTasarim2(title: "Test App", context: context),
          drawer: DrawerPage(
            onPageChange: (index) {
              pageChanger(index);
            },
          ),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: bottomBarDesign(),
          body: IndexedStack(
            index: selectedIndex,
            children: <Widget>[
              GirisSayfasi(menuStart),
              SoruSecmeVeHazirlama(keySoruHazirlama),
              HomeScreen(),
              BlocProvider(
                  create: (BuildContext context) => ProfileBloc(),
                  child: UserProfilePage(
                    returnMainWidget: returnMainWidget,
                  )),
              SettingsOnePage(),
            ],
          )),
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
                Text("Dashboard",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Messages",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Utility Bills",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Funds Transfer",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Branches",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
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
    list.add(
      KFDrawerItem(
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
      ),
    );
  }

  Function onClickAyarlar() {
    Navigator.pushReplacementNamed(context, '/Ayarlar');
  }

  bottomBarDesign() {
    return CurvedNavigationBar(
      index: selectedIndex,
      height: 50.0,
      items: <Widget>[
        Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.add_circle,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.message,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.account_circle,
          size: 30,
          color: Colors.white,
        ),
      ],
      color: Colors.indigo,
      buttonBackgroundColor: Colors.indigo,
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        if (userRepo.durum == UserDurumu.OturumAcik)
          setState(() {
            selectedIndex = index;
          });
        else
          Navigator.pushNamed(context, '/Login');
      },
    );
  }

  Function returnMainWidget() {
    setState(() {
      selectedIndex = 0;
    });
  }

  Function pageChanger(int index) {
    debugPrint('girdi$index');
    setState(() {
      selectedIndex = index;
    });
  }
}
