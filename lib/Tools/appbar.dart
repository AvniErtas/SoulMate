import 'package:flutter/material.dart';

Widget appBarTasarim(String title) {
  return AppBar(
    title: Center(
        child: Text(
      title,
      style: TextStyle(color: Colors.white),
    )),
    flexibleSpace: Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF),
              const Color(0xFF00CCFF),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    ),
  );
}
