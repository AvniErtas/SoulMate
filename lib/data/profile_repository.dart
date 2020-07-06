import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:soulmate/Tools/bildirimKodlari.dart';
import 'package:soulmate/Tools/domain.dart';
import 'package:soulmate/model/user.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  FirebaseAuth _auth;
  FirebaseUser _user;
  ProfileRepository() {
    _auth = FirebaseAuth.instance;
  }

  Future<User> getUser (String uid) async {
    _user = await _auth.currentUser();
    var response =
    await http.post(Domain().getDomainApi() + "/user/fromUid", body: {
      "uid": uid,
      "myUid": _user.uid,
    });
    if (response.statusCode == 200) {
      debugPrint('resp => '+response.body);
      return User.fromRawJson(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<void> setArkadasEkle(String uid) async {
    _user = await _auth.currentUser();
    var response =
    await http.post(Domain().getDomainApi() + "/user/arkadasIslemleri", body: {
      "uid": uid,
      "myUid": _user.uid,
      "bildirimID": arkadasEkle,
    });
    if (response.statusCode == 200) {
//      debugPrint(response.body.toString());
    } else {
      debugPrint(response.statusCode.toString());
    }
  }

  Future<void> setArkadasIstekCek(String uid) async {
    _user = await _auth.currentUser();
    var response =
    await http.post(Domain().getDomainApi() + "/user/arkadasIslemleri", body: {
      "uid": uid,
      "myUid": _user.uid,
      "bildirimID": arkadasIstekCek,
    });
    if (response.statusCode == 200) {
//      debugPrint(response.body.toString());
    return;
    } else {
      debugPrint(response.statusCode.toString());
    }
  }

  Future<void> setArkadasIstekReddet(String uid) async {
    _user = await _auth.currentUser();
    var response =
    await http.post(Domain().getDomainApi() + "/user/arkadasIslemleri", body: {
      "uid":  _user.uid,
      "myUid": uid,
      "bildirimID": arkadasIstekCek,
    });
    if (response.statusCode == 200) {
//      debugPrint(response.body.toString());
      return;
    } else {
      debugPrint(response.statusCode.toString());
    }
  }

  Future<void> setArkadasIstekKabul(String uid) async {
    _user = await _auth.currentUser();
    var response =
    await http.post(Domain().getDomainApi() + "/user/arkadasIslemleri", body: {
      "uid":  _user.uid,
      "myUid": uid,
      "bildirimID": arkadasIstekCek,
    });
    if (response.statusCode == 200) {
//      debugPrint(response.body.toString());
      return;
    } else {
      debugPrint(response.statusCode.toString());
    }
  }
}