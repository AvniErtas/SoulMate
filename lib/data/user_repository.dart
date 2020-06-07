import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum UserDurumu {Idle,OturumAcilmamis,OturumAciliyor,OturumAcik}

class UserRepository with ChangeNotifier {

  FirebaseAuth _auth;
  FirebaseUser _user;
  UserDurumu _durum = UserDurumu.Idle;
  
  UserRepository(){
    _auth = FirebaseAuth.instance;
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }


  FirebaseUser get user => _user;

  set user(FirebaseUser value) {
    _user = value;
  }

  UserDurumu get durum => _durum;

  set durum(UserDurumu value) {
    _durum = value;
  }

  Future<bool> signIn(String email,String sifre) async{
    try{
      _durum = UserDurumu.OturumAciliyor;
      notifyListeners();
      _auth.signInWithEmailAndPassword(email: email, password: sifre);
      return true;
    }catch(e){
      _durum = UserDurumu.OturumAcilmamis;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _durum = UserDurumu.OturumAcilmamis;
    notifyListeners();
    debugPrint('Cikis yapildi');
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser user) async{
      if(user == null) {
        _durum = UserDurumu.OturumAcilmamis;
      } else {
        _user = user;
        debugPrint(_user.email);
        _durum = UserDurumu.OturumAcik;
      }

      notifyListeners();
  }


}