const String arkadasEkle = 'arkadasEkle';
const String arkadasSil = 'arkadasSil';
const String arkadasIstekCek = 'arkadasIstekCek';

class BildirimHazirla {

  String getBildirim(String bildirimKodu,String kullanici_ismi) {
    switch (bildirimKodu) {
      case arkadasEkle:
        return '$kullanici_ismi kişisi sizi arkadaş olarak ekledi';
        break;
    }
  }
}
