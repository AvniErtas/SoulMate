import 'package:flutter/material.dart';
import 'package:soulmate/Tools/appbar.dart';


class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTasarim2("Geri Bildirim"),
    );
  }
}
