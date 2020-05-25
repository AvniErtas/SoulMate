import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Pages/Sonuclar/sonuclar.dart';
import 'package:soulmate/Tools/kategoriResimleri.dart';
import 'package:soulmate/Widgets/AppBarWithScaffold.dart';
import 'package:soulmate/Widgets/Cards/gradientcard.dart';
import 'package:soulmate/blocs/TestBloc/bloc.dart';
import 'package:soulmate/blocs/TestBloc/test_bloc.dart';


enum WhyFarther { sonuc, paylas }

class SonuclarTestler extends StatefulWidget {
  @override
  _SonuclarTestlerState createState() => _SonuclarTestlerState();
}

class _SonuclarTestlerState extends State<SonuclarTestler> {
  //String _selection;
  WhyFarther _selection;
  @override
  Widget build(BuildContext context) {
    return appBarWithScaffold(sonuclar(), GradientColors.Background1, "Sonuç İncele");


  }
  Widget sonuclar() {
    final _testBloc = BlocProvider.of<TestBloc>(context);
    _testBloc.add(FetchSonucEvent());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double cardWidth = width * 0.2;
    double cardHeight = height * 0.15;
    return Column(
      children: <Widget>[
        Expanded(
          child : BlocBuilder<TestBloc,TestState>(
              bloc: _testBloc,
              builder: (context, TestState state) {
                if (state is TestUninitialized) {
                  return Text("UNINIT");
                } else if (state is TestLoading) {
                  return new Center(
                    child: new CircularProgressIndicator(),
                  );
                } else if (state is TestLoaded) {
                  return  ListView.builder(
                    itemCount: state.Tests.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SonucInceleme())),
                        child: Container(
                          height: cardHeight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: GradientCard(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            gradient: GradientColors.anasayfaswiper,
                            child: Center(
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: width * 0.2,
                                    height: height * 0.08,
                                    child: Image.asset(kategoriImageURL[index],
                                        fit: BoxFit.contain),
                                  ),
                                ),
                                title: Text(
                                  state.Tests[index].testAdi,
                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                ),
                                trailing: popUp(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is TestError) {
                  return Text("İnternet yok amk");
                }else {

                  return Text("state");
                }
              }),
        ),
      ],
    );
  }
  Widget popUp() {
    return PopupMenuButton<WhyFarther>(
      elevation: 4,
      icon: Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      onSelected: (WhyFarther result) {
        setState(() {
          _selection = result;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.sonuc,
          child: Text(
            "Sonuç İncele",
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
}
