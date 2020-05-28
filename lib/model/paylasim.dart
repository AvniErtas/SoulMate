// To parse this JSON data, do
//
//     final paylasim = paylasimFromJson(jsonString);

import 'dart:convert';

import 'package:soulmate/model/paylasilan.dart';

class Paylasim {
  String id;
  String testID;
  String paylasanAdi;
  String paylasanUid;
  List<int> paylasanCevaplari;
  List<Paylasilan> paylasilan;

  Paylasim({
    this.id,
    this.testID,
    this.paylasanAdi,
    this.paylasanUid,
    this.paylasanCevaplari,
    this.paylasilan,
  });

  factory Paylasim.fromRawJson(String str) => Paylasim.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Paylasim.fromJson(Map<String, dynamic> json) => Paylasim(
    id: json["id"],
    testID: json["testID"],
    paylasanAdi: json["paylasanAdi"],
    paylasanUid: json["paylasanUid"],
    paylasanCevaplari: List<int>.from(json["paylasanCevaplari"].map((x) => x)),
    paylasilan: List<Paylasilan>.from(json["paylasilan"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "testID": testID,
    "paylasanAdi": paylasanAdi,
    "paylasanUid": paylasanUid,
    "paylasanCevaplari": List<dynamic>.from(paylasanCevaplari.map((x) => x)),
    "paylasilan": paylasilan == null ? null : List<dynamic>.from(paylasilan.map((x) => x)),
  };
}
