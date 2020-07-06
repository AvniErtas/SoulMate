import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soulmate/Tools/domain.dart';
import 'package:soulmate/model/bildirim.dart';

class BildirimRepository {
  FirebaseAuth _auth;
  FirebaseUser _user;
  BildirimRepository() {
    _auth = FirebaseAuth.instance;
  }

  Future<List<Bildirim>> getBildirim () async {
    _user = await _auth.currentUser();
    var response =
    await http.post(Domain().getDomainApi() + "/user/getNotifications", body: {
      "uid": _user.uid,
    });
    if (response.statusCode == 200) {
      debugPrint('bildirim => '+response.body);
      return (json.decode(response.body) as List)
          .map((tekGonderiMap) => Bildirim.fromJson(tekGonderiMap))
          .toList();
    } else {
      throw Exception('Failed to load notification');
    }
  }

}