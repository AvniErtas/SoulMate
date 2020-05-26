import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Pages/Kesfet/filterchip.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:flutter/widgets.dart';
import 'package:soulmate/Widgets/AppBarWithScaffold.dart';
import 'package:soulmate/Widgets/Cards/gradientcard.dart';
import 'package:soulmate/blocs/TestBloc/bloc.dart';
import 'package:soulmate/blocs/TestBloc/test_bloc.dart';

class KesfetEski extends StatelessWidget {
  double height;
  double width;
 //TODO bloc yapısını hazırla
  @override
  Widget build(BuildContext context) {

    
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return appBarWithScaffold(kesfetTasarim(context), GradientColors.Background1, "Keşfet");
  }
  Widget kesfetTasarim(BuildContext context) {
    final _testBloc = BlocProvider.of<TestBloc>(context);
    _testBloc.add(FetchKesfetEvent());
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Align(
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => Material(
                      type: MaterialType.transparency,
                      child: Center( // Aligns the container to center
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: FilterChipDisplay(),
                        ),
                      ),
                    )
                );
              },
              child: Icon(
                Icons.filter_list,
                size: 30,
              ),
            ),
            alignment: Alignment.centerRight,
          ),
          BlocBuilder<TestBloc,TestState>(
              bloc: _testBloc,
              builder: (context, TestState state) {
                if (state is TestUninitialized) {
                  return Text("UNINIT");
                } else if (state is TestLoading) {
                  return new Center(
                    child: new CircularProgressIndicator(),
                  );
                } else if (state is TestLoaded) {
                  return     Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: GridView.builder(
                          shrinkWrap: true,
                          primary: true,
                          itemCount: 10,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return CardDesign();
                          }),
                    ),
                  );
                } else if (state is TestError) {
                  return Text("İnternet yok amk");
                }else {

                  return Text("state");
                }
              }),

        ],
      ),
    );
  }
  Widget CardDesign() {
    return GradientCard(
      gradient: GradientColors.listGradient,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipOval(
                child: FadeInImage(
                  image: NetworkImage("imageurl"),
                  fit: BoxFit.cover,
                  width: width/6,
                  height: height/10,
                  placeholder: AssetImage("assets/profile.jpeg"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "Eum perferendis voluptatibus qui illo. Nemo quos voluptatum reiciendluptatibus labore ab odioum reiciendluptatibus labore ab odio.",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(fontSize: 14,color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyFlutterApp {
  MyFlutterApp._();

  static const _kFontFam = 'MyFlutterApp';
  static const _kFontPkg = '';

  static const IconData filter =
      const IconData(0xf0b0, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
