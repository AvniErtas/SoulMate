// To parse this JSON data, do
//
//     final test = testFromJson(jsonString);

import 'dart:convert';

Test testFromJson(String str) => Test.fromJson(json.decode(str));

String testToJson(Test data) => json.encode(data.toJson());

class Test {
  Test({
    this.id,
    this.testAdi,
    this.kategori,
    this.image,
    this.olusturanUid,
    this.olusturanTipi,
    this.olusturmaTarihi,
    this.sorular,
  });

  String id;
  String testAdi;
  String kategori;
  String image;
  String olusturanUid;
  String olusturanTipi;
  String olusturmaTarihi;
  List<Sorular> sorular;

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    id: json["id"] == null ? null : json["id"],
    testAdi: json["testAdi"] == null ? null : json["testAdi"],
    kategori: json["kategori"] == null ? null : json["kategori"],
    image: json["image"] == null ? null : json["image"],
    olusturanUid: json["olusturanUid"] == null ? null : json["olusturanUid"],
    olusturanTipi: json["olusturanTipi"] == null ? null : json["olusturanTipi"],
    olusturmaTarihi: json["olusturmaTarihi"] == null ? null : json["olusturmaTarihi"],
    sorular: json["sorular"] == null ? null : List<Sorular>.from(json["sorular"].map((x) => Sorular.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "testAdi": testAdi == null ? null : testAdi,
    "kategori": kategori == null ? null : kategori,
    "image": image == null ? null : image,
    "olusturanUid": olusturanUid == null ? null : olusturanUid,
    "olusturanTipi": olusturanTipi == null ? null : olusturanTipi,
    "olusturmaTarihi": olusturmaTarihi == null ? null : olusturmaTarihi,
    "sorular": sorular == null ? null : List<dynamic>.from(sorular.map((x) => x.toJson())),
  };
}

class Sorular {
  Sorular({
    this.soruTipi,
    this.soru,
    this.siklar,
  });

  int soruTipi;
  String soru;
  List<String> siklar;

  factory Sorular.fromJson(Map<String, dynamic> json) => Sorular(
    soruTipi: json["soruTipi"] == null ? null : json["soruTipi"],
    soru: json["soru"] == null ? null : json["soru"],
    siklar: json["siklar"] == null ? null : List<String>.from(json["siklar"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "soruTipi": soruTipi == null ? null : soruTipi,
    "soru": soru == null ? null : soru,
    "siklar": siklar == null ? null : List<dynamic>.from(siklar.map((x) => x)),
  };
}
