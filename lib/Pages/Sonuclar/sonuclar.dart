import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Pages/Sonuclar/sonuc_incele.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/Widgets/AppBarWithScaffold.dart';
import 'package:soulmate/Widgets/Cards/gradientcard.dart';
import 'package:soulmate/blocs/SonucBloc/bloc.dart';

enum WhyFarther { favoritest, sonracoz, paylas }

class SonucInceleme extends StatefulWidget {
  @override
  _SonucIncelemeState createState() => _SonucIncelemeState();
}

class _SonucIncelemeState extends State<SonucInceleme> {
  WhyFarther _selection;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double cardWidth = width * 0.2;
    double cardHeight = height * 0.15;
    return appBarWithScaffold(stackDesign(cardHeight), GradientColors.Background1, "Sonuçlar");
  }
  Widget popUp() {
    return PopupMenuButton<WhyFarther>(
      elevation: 4,
      icon: Icon(
        Icons.share,
        color: Colors.black,
      ),
      onSelected: (WhyFarther result) {
        setState(() {
          _selection = result;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.favoritest,
          child: Text("Favorilerime Ekle",
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.sonracoz,
          child: Text(
            "Daha sonra çöz",
            style: TextStyle(fontSize: 15),
          ),
        ),
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.paylas,
          child: Text(
            "Paylaş",
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }

  Widget stackDesign(double cardHeight) {
    final _sonucBloc = BlocProvider.of<SonucBloc>(context);
    _sonucBloc.add(FetchSonucEvent());
    return  BlocBuilder<SonucBloc,SonucState>(
        bloc: _sonucBloc,
        builder: (context, SonucState state) {
          if (state is SonucUninitialized) {
            return Text("UNINIT");
          } else if (state is SonucLoading) {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          } else if (state is SonucLoaded) {
            return Container(

              child: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SonucIncele())),
                    child: Container(
                      height: cardHeight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: GradientCard(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        gradient: GradientColors.lovetonight,
                        child: Center(
                          child: ListTile(
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.asset("assets/profile.jpeg"),
                                ),
                                VerticalDivider(
                                  color: Colors.white,
                                  width: 10,
                                  thickness: 1.50,
                                ),
                              ],
                            ),
                            title: Text(
                              state.users[index].username,
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'Test Puanı : ',
                                    style: TextStyle(
                                      fontFamily: 'roboto',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.indigoAccent,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      state.users[index].friendLength.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: popUp(),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is SonucError) {
            return Text("İnternet yok amk");
          }else {

            return Text("state");
          }
        });
  }
}
