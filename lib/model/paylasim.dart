// To parse this JSON data, do
//
//     final paylasim = paylasimFromJson(jsonString);

import 'dart:convert';

class Paylasim {
  String id;
  String paylasanAdi;
  String paylasanUid;
  String paylasilanUid;
  List<String> paylasanCevaplari;
  List<String> paylasilanCevaplari;

  Paylasim({
    this.id,
    this.paylasanAdi,
    this.paylasanUid,
    this.paylasilanUid,
    this.paylasanCevaplari,
    this.paylasilanCevaplari,
  });

  factory Paylasim.fromRawJson(String str) => Paylasim.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Paylasim.fromJson(Map<String, dynamic> json) => Paylasim(
    id: json["id"],
    paylasanAdi: json["paylasanAdi"],
    paylasanUid: json["paylasanUid"],
    paylasilanUid: json["paylasilanUid"],
    paylasanCevaplari: List<String>.from(json["paylasanCevaplari"].map((x) => x)),
    paylasilanCevaplari: List<String>.from(json["paylasilanCevaplari"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "paylasanAdi": paylasanAdi,
    "paylasanUid": paylasanUid,
    "paylasilanUid": paylasilanUid,
    "paylasanCevaplari": List<dynamic>.from(paylasanCevaplari.map((x) => x)),
    "paylasilanCevaplari": List<dynamic>.from(paylasilanCevaplari.map((x) => x)),
  };
}
