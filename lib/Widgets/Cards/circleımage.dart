import 'package:flutter/material.dart';

Widget circleImages(String title) {
  return Container(
    decoration: new BoxDecoration(
      image: DecorationImage(
        image: new AssetImage('assets/profile.jpeg'),
        fit: BoxFit.contain,
      ),
      shape: BoxShape.circle,
    ),
  );
}
