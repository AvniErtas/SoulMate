import 'package:soulmate/model/test.dart';

class AnaSayfaRepository {

  List<List<Test>> getAnaSayfaTest() {
    List< List<Test>> anasayfaTestler = new List< List<Test>>();

    List<Test> testlerPopuler = new List<Test>();
    testlerPopuler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test başlığxxxıdır 1 ???'));
    testlerPopuler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test soasdsdrusudur 2 ???'));
    testlerPopuler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorasdsadusudur 3 ???'));
    testlerPopuler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test soruddsudur 4 ???'));
    testlerPopuler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorucccsudur 5 ???'));


    List<Test> testlerEnCok = new List<Test>();
    testlerEnCok.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test kategorisd 1 ???'));
    testlerEnCok.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test axsx 2 ???'));
    testlerEnCok.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test xasaa 3 ???'));
    testlerEnCok.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test aaaa 4 ???'));
    testlerEnCok.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test xsdsd 5 ???'));

    anasayfaTestler.add(testlerPopuler);
    anasayfaTestler.add(testlerEnCok);

    return anasayfaTestler;
  }



}