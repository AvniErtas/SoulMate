import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Pages/Kesfet/filterchip.dart';
import 'package:soulmate/Tools/kategoriResimleri.dart';
import 'package:soulmate/Widgets/AppBarWithScaffold.dart';
import 'package:soulmate/Widgets/Cards/gradientcard.dart';
import 'package:soulmate/blocs/TestBloc/bloc.dart';
import 'package:soulmate/blocs/TestBloc/test_bloc.dart';

enum WhyFarther { favoritest, sonracoz, paylas }

class CozdugumTestler extends StatefulWidget {
  @override
  _CozdugumTestlerState createState() => _CozdugumTestlerState();
}

class _CozdugumTestlerState extends State<CozdugumTestler> {
  //String _selection;
  WhyFarther _selection;
  String dropdownValue = '1';

  List<String> spinnerItems = ["1", "2", "3"];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return appBarWithScaffold(
        testlerTasarim(width, height), GradientColors.Background1, "Testlerim");
  }

  Widget testlerTasarim(double width, double height) {
    final _testBloc = BlocProvider.of<TestBloc>(context);
    _testBloc.add(FetchKesfetEvent());
    double cardWidth = width * 0.2;
    double cardHeight = height * 0.15;
    return Column(
      children: <Widget>[
        Align(
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => Material(
                        type: MaterialType.transparency,
                        child: Center(
                          // Aligns the container to center
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: FilterChipDisplay(
                              callback: (secilenler) {
                                ///TODO sayfayı filtrele
                                /// _testBloc.add(FetchFiltreleEvent(kategoriAdi));
                              },
                            ),
                          ),
                        ),
                      ));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.filter_list,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          alignment: Alignment.centerRight,
        ),
        Expanded(
          child: BlocBuilder<TestBloc, TestState>(
              bloc: _testBloc,
              builder: (context, TestState state) {
                if (state is TestUninitialized) {
                  return Text("Yukleniyor");
                } else if (state is TestLoading) {
                  return new Center(
                    child: new CircularProgressIndicator(),
                  );
                } else if (state is TestLoaded) {
                  return ListView.builder(
                    itemCount: state.Tests.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: cardHeight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: GradientCard(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          gradient: GradientColors.cardProfile,
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
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
//                                      state.Tests[index].sorular.length.toString(),
                                  5.toString(),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              trailing: popUp(),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is TestError) {
                  return Text("İnternet yok amk");
                } else {
                  return Text("state");
                }
              }),
        ),
        Column(children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 30, 10),
              child: Theme(
                data: Theme.of(context).copyWith(brightness: Brightness.dark),
                child: DropdownButton(
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  style: TextStyle(
                      color: Colors.blue, decorationColor: Colors.black),
                  items: spinnerItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  value: null,
                  hint: Text(dropdownValue,
                      style: TextStyle(color: Colors.white)),
                  onChanged: (String data) {
                    setState(() {
                      dropdownValue = data;
                    });
                  },
                ),
              ),
            ),
          ),
        ]),
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
          if (result == WhyFarther.favoritest) {
            Navigator.pushNamed(context, '/FavoriTestlerim');
          } else if (result == WhyFarther.paylas) {
            Navigator.pushNamed(context, '/PaylasmaBolumu');
          }
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
