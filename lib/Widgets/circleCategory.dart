import 'package:flutter/material.dart';
import 'package:soulmate/Tools/kategoriResimleri.dart';


class CategoryChooser extends StatelessWidget {
  final Function(String) onTap;
  const CategoryChooser({
    Key key,
    this.onTap,
  }) : super(key: key);
  final List<String> types = const [
    "Eğlence",'Kitap','İş','Film-Dizi','Gezi','Aile','Teknoloji','Yaşam Tarzı','Aşk','Yemek','Ahlaki İkiliem','Diğer'
  ];


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height*0.12,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        itemBuilder: (context, index) {
          String type = types[index];
          return GestureDetector(
            onTap: onTap != null ? () => onTap(type) : null,
            child: Column(
              children: <Widget>[
                Container(
                  width: width*0.16,
                  height: height*0.07,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(kategoriImageURL[index]),),
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  type,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: width*0.025,
        ),
      ),
    );
  }
}