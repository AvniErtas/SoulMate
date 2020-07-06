import 'dart:convert';

class Bildirim {
  String bildirimID;
  String gonderenUid;
  String gonderenAdi;
  String date;

  Bildirim({this.bildirimID, this.gonderenUid,this.gonderenAdi, this.date});

  factory Bildirim.fromRawJson(String str) => Bildirim.fromJson(json.decode(str));

  factory Bildirim.fromJson(Map<String, dynamic> json) => Bildirim(
      bildirimID: json["bildirimID"] == null ? null : json["bildirimID"],
      gonderenUid: json["gonderenUid"] == null ? null : json["gonderenUid"],
      gonderenAdi: json["gonderenAdi"] == null ? null : json["gonderenAdi"],
      date: json["date"] == null ? null : json["date"]
  );


}