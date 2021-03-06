class TestPaylasimlari {
  TestPaylasimlari({
    this.soruTipi,
    this.soru,
    this.siklar,
  });

  String paylasanUid;
  String paylasanCevapId ;
  List<String> siklar;

  factory TestPaylasimlari.fromJson(Map<String, dynamic> json) => TestPaylasimlari(
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
