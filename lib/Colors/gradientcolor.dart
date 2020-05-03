import 'package:flutter/material.dart';

class GradientColors {
  static final AlignmentGeometry _beginAlignment = Alignment.topLeft;
  static final AlignmentGeometry _endAlignment = Alignment.bottomRight;
  static final AlignmentGeometry _beginverticalAlignment = Alignment.topCenter;
  static final AlignmentGeometry _endverticalAlignment = Alignment.bottomCenter;
  static final AlignmentGeometry centerAlignment = Alignment.center;


  static LinearGradient buildGradient(AlignmentGeometry begin, AlignmentGeometry end, List<Color> colors) =>
      LinearGradient(begin: begin, end: end, colors: colors);

  static const hotLinear = LinearGradient(
      colors: [Color(0xffF55B9A), Color(0xffF9B16E)], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static LinearGradient coralCandyGradient =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffFFF0D1), Color(0xffFFB8C6)]);

  static LinearGradient serve =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff485563), Color(0xff485563)]);

  static LinearGradient ali =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffff4b1f), Color(0xff1fddff)]);

  static LinearGradient aliHussien =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xfff7ff00), Color(0xffdb36a4)]);

  static LinearGradient backToFuture =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffC02425), Color(0xffF0CB35)]);

  static LinearGradient tameer =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff136a8a), Color(0xff267871)]);

  static LinearGradient rainbowBlue =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff1fddff), Color(0xff0575E6)]);

  static LinearGradient blush =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffB24592), Color(0xffF15F79)]);

  static LinearGradient byDesign =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff009FFF), Color(0xffec2F4B)]);

  static LinearGradient haze =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffE8EDF4), Color(0xffF6F6F8)]);

  static LinearGradient jShine =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff12c2e9), Color(0xffc471ed), Color(0xfff64f59)]);

  static LinearGradient hersheys = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xfff1e130c),
    Color(0xff9a8478),
  ]);

  static LinearGradient taitanum = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xff283048),
    Color(0xff859398),
  ]);

  static LinearGradient cosmicFusion = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xfffff00cc),
    Color(0xff333399),
  ]);

  static LinearGradient coldLinear = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xfff20BDFF),
    Color(0xffA5FECB),
  ]);

  static LinearGradient deepSpace = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xff000000),
    Color(0xff434343),
  ]);

  static LinearGradient anasayfaswiper = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xff465DE2),
    Color(0xff764BA2),
  ]);

  static LinearGradient eglence = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xffFF416C),
    Color(0xff8A52E9),
  ]);

  static LinearGradient kitap = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xffFFA72F),
    Color(0xffFF641A),
  ]);
  
  static LinearGradient kategoriis = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xff1EFFC2),
    Color(0xff0A04BF),
  ]);

  static LinearGradient filmdizi = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xffFF7765),
    Color(0xffF7A23C),
  ]);

  static LinearGradient gezi = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xffEF32D9),
    Color(0xff376DF6),
  ]);

  static LinearGradient aile = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xff21E8AC),
    Color(0xff376DF6),
  ]);
  static LinearGradient teknoloji = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xff0C1DB5),
    Color(0xffBEE4F8),
  ]);
  static LinearGradient yasamtarzi = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xffF3866B),
    Color(0xff6FEE00),
  ]);
  static LinearGradient ask = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xffFF0101),
    Color(0xff764BA2),
  ]);
  static LinearGradient yemek = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xffC69FA8),
    Color(0xff0247AF),
  ]);
  static LinearGradient ahlakiikilem = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xff465DE2),
    Color(0xff764BA2),
  ]);
  static LinearGradient diger = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xff7EFFFF),
    Color(0xff0962A7),
  ]);
  static LinearGradient arkaplan = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xff7EFFFF),
    Color(0xff0962A7),
  ]);
  static LinearGradient sevgiliye = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xffAC0707),
    Color(0xffFFFFFF),
  ]);
  static LinearGradient florte = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xff5D13CE),
    Color(0xffFFFFFF),
  ]);
  static LinearGradient kadin = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xffBB00D8),
    Color(0xffFFFFFF),
  ]);
  static LinearGradient erkek = buildGradient(_beginAlignment, _endAlignment, const [
    Color(0xff0011FF),
    Color(0xffFFFFFF),
  ]);

   static LinearGradient cardProfile = buildGradient(_beginverticalAlignment, _endverticalAlignment, const [
    Colors.blueAccent,
    Colors.white,
  ]);
  
}


class KategoriRenkler {
  KategoriRenkler(this.gradient, this.name);

  LinearGradient gradient;
  String name;
}

List<KategoriRenkler> renkler = [
  KategoriRenkler(GradientColors.eglence,"Eğlence"),
  KategoriRenkler(GradientColors.kitap,"Kitap"),
  KategoriRenkler(GradientColors.kategoriis,"İş"),
  KategoriRenkler(GradientColors.filmdizi,"Film-Dizi"),
  KategoriRenkler(GradientColors.gezi,"Gezi"),
  KategoriRenkler(GradientColors.aile,"Aile"),
  KategoriRenkler(GradientColors.teknoloji,"Teknoloji"),
  KategoriRenkler(GradientColors.yasamtarzi,"Yaşam Tarzı"),
  KategoriRenkler(GradientColors.ask,"Aşk"),
  KategoriRenkler(GradientColors.yemek,"Yemek"),
  KategoriRenkler(GradientColors.ahlakiikilem,"Ahlaki İkilem"),
  KategoriRenkler(GradientColors.diger,"Diğer"),
  KategoriRenkler(GradientColors.sevgiliye,"Sevgiliye"),
  KategoriRenkler(GradientColors.florte,"Flörte"),
  KategoriRenkler(GradientColors.kadin,"Kadın"),
  KategoriRenkler(GradientColors.erkek,"Erkek"),
  
];