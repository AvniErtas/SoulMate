import 'dart:convert';

class Bildirim {
  String bildirimID;
  String gonderenUid;
  String gonderenAdi;
  String testId;
  String paylasimId;
  String date;

  Bildirim({this.bildirimID, this.gonderenUid,this.gonderenAdi, this.date,this.testId,this.paylasimId});

  factory Bildirim.fromRawJson(String str) => Bildirim.fromJson(json.decode(str));

  factory Bildirim.fromJson(Map<String, dynamic> json) => Bildirim(
      bildirimID: json["bildirimID"] == null ? null : json["bildirimID"],
      gonderenUid: json["gonderenUid"] == null ? null : json["gonderenUid"],
      gonderenAdi: json["gonderenAdi"] == null ? null : json["gonderenAdi"],
      testId: json["testId"] == null ? null : json["testId"],
      paylasimId: json["paylasimId"] == null ? null : json["paylasimId"],
      date: json["date"] == null ? null : json["date"]
  );

  @override
  String toString() {
    return 'Bildirim{bildirimID: $bildirimID, gonderenUid: $gonderenUid, gonderenAdi: $gonderenAdi, extra: $testId, date: $date}';
  }
}