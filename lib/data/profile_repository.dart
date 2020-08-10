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

  Future<int> setArkadasEkle(String uid) async {
    _user = await _auth.currentUser();
    var response =
    await http.post(Domain().getDomainApi() + "/user/arkadasIslemleri", body: {
      "uid": uid,
      "myUid": _user.uid,
      "bildirimID": arkadasEkle,
    });
    if (response.statusCode == 200) {
//      debugPrint(response.body.toString());
      return response.statusCode;
    } else {
      debugPrint(response.statusCode.toString());
      return response.statusCode;
    }
  }

  Future<int> setArkadasIstekCek(String uid) async {
    _user = await _auth.currentUser();
    var response =
    await http.post(Domain().getDomainApi() + "/user/arkadasIslemleri", body: {
      "uid": uid,
      "myUid": _user.uid,
      "bildirimID": arkadasIstekCek,
    });
    if (response.statusCode == 200) {
//      debugPrint(response.body.toString());
      return response.statusCode;
    } else {
      debugPrint(response.statusCode.toString());
      return response.statusCode;
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
      return response.statusCode;
    } else {
      debugPrint(response.statusCode.toString());
      return response.statusCode;
    }
  }

  Future<int> setArkadasIstekKabul(String uid) async {
    _user = await _auth.currentUser();
    var response =
    await http.post(Domain().getDomainApi() + "/user/arkadasIslemleri", body: {
      "uid":  _user.uid,
      "myUid": uid,
      "bildirimID": arkadasIstekKabul,
    });
    if (response.statusCode == 200) {
//      debugPrint(response.body.toString());
      return response.statusCode;
    } else {
      debugPrint(response.statusCode.toString());
      return response.statusCode;
    }
  }

  Future<void> arkadasSil(String uid) async {
    _user = await _auth.currentUser();
    var response =
    await http.post(Domain().getDomainApi() + "/user/arkadasIslemleri", body: {
      "uid":  uid,
      "myUid": _user.uid,
      "bildirimID": arkadasIstekKabul,
    });
    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
    } else {
      debugPrint(response.statusCode.toString());
    }
  }
}