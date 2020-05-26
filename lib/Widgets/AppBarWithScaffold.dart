
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Tools/appbar.dart';

Widget appBarWithScaffold (Widget safeAreaWidget,LinearGradient color,String title) {

  return Container(
    decoration: BoxDecoration(
      gradient: color,
    ),
    child: Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: appBarTasarim2(title),
      body: Stack(
        children: <Widget>[
          ClipPath(
            //appbar'ın arka planı için hazır yapı
            clipper: DiagonalPathClipperOne(),
            child: Container(
              height: 200,
              color: Colors.cyan,
            ),
          ),
          SafeArea(
            child: safeAreaWidget,
          ),
        ],
      ),

    ),
  );
}