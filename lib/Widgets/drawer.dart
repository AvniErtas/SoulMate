import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Pages/giris.dart';
import 'package:soulmate/blocs/UserSearchBloc/user_bloc.dart';

import 'dataSearch.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////////
//Drawer'ın hazırlanması

class DrawerPage extends StatefulWidget {
  Function onPageChange;

  DrawerPage({this.onPageChange});

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return buildDrawer();
  }

  Widget buildDrawer() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double drawerWidth = width * 0.65;

    final String image = "assets/images/21.jpg";
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Container(
        width: drawerWidth,
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 30),
            decoration: BoxDecoration(
                gradient: GradientColors.Background1,
                boxShadow: [BoxShadow(color: Colors.black45)]),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    /* user != null //user giriş yaptıysa foto ve kullanıcı adı getirilecek,yapmadıysa giriş yapın yazısı çıkacak.
                      ? _profilHazirla()
                      : Text(
                    "Üye girişi yapmak için tıklayınız",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600),
                  ),*/
                    SizedBox(height: 30.0),
                    drawerList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget drawerList() {
    List<String> titles = [
      'Anasayfa',
      'Soru Hazırla',
      'Kullanıcı Ara',
      'Bildirimler',
      'Ayarlar',
      'Geri Bildirim',
      'Yardım'
    ];
    List<Icon> icons = [
      Icon(
        Icons.home,
        color: Colors.white,
      ),
      Icon(Icons.settings, color: Colors.white),
      Icon(Icons.search, color: Colors.white),
      Icon(Icons.send, color: Colors.white),
      Icon(Icons.info_outline, color: Colors.white),
      Icon(Icons.send, color: Colors.white),
      Icon(Icons.help, color: Colors.white)
    ];

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: titles.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.pop(context);
            switch (index) {
              case 0:
                widget.onPageChange(index);
                break;
              case 1:
                widget.onPageChange(index);
                break;
              case 2:
                showSearch(context: context, delegate: DataSearch(BlocProvider.of<UserSearchBloc>(context)));
                break;
              case 3:
                Navigator.pushNamed(context, '/Bildirimler');
                break;
              case 4:
                Navigator.pushNamed(context, '/Ayarlar');
                break;
              case 5:
                Navigator.pushNamed(context, '/GeriBildirim');
                break;
              case 6:
                GirisSayfasiState.showTutorial();
                break;
            }
          },
          child: Column(
            children: <Widget>[
              _buildRow(icons[index], titles[index]),
              _buildDivider(),
            ],
          ),
        );
      },
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////
//Drawer satırlarının içinin hazırlanması
  Widget _buildRow(Icon icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: Colors.white, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        icon,
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
        if (showBadge) //bildirim sayısını göstermek için olan yapı
          Material(
            color: Colors.deepOrange,
            elevation: 5.0,
            shadowColor: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                "10+",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
      ]),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////
  Divider _buildDivider() {
    return Divider(
      color: Colors.white,
    );
  }
}
