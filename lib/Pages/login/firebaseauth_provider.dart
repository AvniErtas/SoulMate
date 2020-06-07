import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:soulmate/Pages/login/login_screen.dart';
import 'package:soulmate/data/user_repository.dart';

import '../Kategoriler.dart';

class ProviderwithFirebaseAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, UserRepository userRepo, child) {
      switch (userRepo.durum) {
        case UserDurumu.Idle:
          return SplashEkran();
        case UserDurumu.OturumAciliyor:
        case UserDurumu.OturumAcilmamis:
          return LoginScreen();
        case UserDurumu.OturumAcik:
          return KategoriBolumu();
      }
    });
  }
}

class SplashEkran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash Ekran"),
      ),
      body: Center(
        child: Text("Splash"),
      ),
    );
  }
}