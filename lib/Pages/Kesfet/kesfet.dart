import 'package:flutter/material.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Pages/Kesfet/filterchip.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:flutter/widgets.dart';
import 'package:soulmate/Widgets/Cards/gradientcard.dart';

class Kesfet extends StatelessWidget {
  double height;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: appBarTasarim("title"),
      body: Padding(
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
            Expanded(
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
            ),
          ],
        ),
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
                  width: 80.0,
                  height: 80.0,
                  placeholder: AssetImage("assets/profile.jpeg"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "Eum perferendis voluptatibus qui illo. Nemo quos voluptatum reiciendis labore reprehenderit iure vel. Optio quod nihil voluptatibus labore ab odio.",
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
