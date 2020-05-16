// To parse this JSON data, do
//
//     final test = testFromJson(jsonString);

import 'dart:convert';

class Test {
  String id;
  String testAdi;
  String kategori;
  String image;
  String olusturanUid;
  String olusturanTipi;
  String olusturmaTarihi;
  List<Sorular> sorular;

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

  factory Test.fromRawJson(String str) => Test.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    id: json["id"],
    testAdi: json["testAdi"],
    kategori: json["kategori"],
    image: json["image"],
    olusturanUid: json["olusturanUid"],
    olusturanTipi: json["olusturanTipi"],
    olusturmaTarihi: json["olusturmaTarihi"],
    sorular: List<Sorular>.from(json["sorular"].map((x) => Sorular.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "testAdi": testAdi,
    "kategori": kategori,
    "image": image,
    "olusturanUid": olusturanUid,
    "olusturanTipi": olusturanTipi,
    "olusturmaTarihi": olusturmaTarihi,
    "sorular": List<dynamic>.from(sorular.map((x) => x.toJson())),
  };
}

class Sorular {
  int soruTipi;
  String soru;
  List<String> siklar;

  Sorular({
    this.soruTipi,
    this.soru,
    this.siklar,
  });

  factory Sorular.fromRawJson(String str) => Sorular.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sorular.fromJson(Map<String, dynamic> json) => Sorular(
    soruTipi: json["soruTipi"],
    soru: json["soru"],
    siklar: json["siklar"] == null ? null : List<String>.from(json["siklar"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "soruTipi": soruTipi,
    "soru": soru,
    "siklar": siklar == null ? null : List<dynamic>.from(siklar.map((x) => x)),
  };
}
