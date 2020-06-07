import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soulmate/Tools/domain.dart';
import 'package:soulmate/model/test.dart';
import 'package:http/http.dart' as http;

class TestRepository {

  List <Test> getPopulerTest() {
    List<Test> testler = new List<Test>();
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Popüler???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test soasdsdrusudur 2 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test sorasdsadusudur 3 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test soruddsudur 4 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test sorucccsudur 5 ???'));
    return testler;
  }

  List <Test> getKategoriTest() {
    List<Test> testler = new List<Test>();
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Kategori??'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test axsx 2 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test xasaa 3 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test aaaa 4 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test xsdsd 5 ???'));
    return testler;
  }

  List <Test> getSonucTestler(String uid) {
    List<Test> testler = new List<Test>();
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Sonuçççç'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test axsx 2 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test xasaa 3 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test aaaa 4 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test xsdsd 5 ???'));
    return testler;
  }

  List <Test> getKesfetTestler() {
    List<Test> testler = new List<Test>();
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Keşfettt'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test axsx 2 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test xasaa 3 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test aaaa 4 ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Bu bir test xsdsd 5 ???'));
    return testler;
  }

  Future <Test> getTestFromId(String id) async{
    int i=0;
    var response =
    await http.post(Domain().getDomainApi() + "/test/id", body: {
      "id": id,
    });
    if (response.statusCode == 200) {
//      final gelenJson = jsonDecode(response.body);
      debugPrint(response.body);
      return testFromJson((response.body));
//      return Test.fromJson(gelenJson);
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception('Failed to load post');
    }
   /* Test test = new Test();
    List<Sorular> sorular = new List<Sorular>();
    sorular.add(new Sorular(soruTipi: 0,soru: 'Soru 111'));
    sorular.add(new Sorular(soruTipi: 0,soru: 'Soru 222'));
    sorular.add(new Sorular(soruTipi: 1,soru: 'Soru 333'));
    sorular.add(new Sorular(soruTipi: 2,soru: 'Soru 444'));
    test = new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: "11111",testAdi: 'Sonuçççç',sorular: sorular);
*/

  debugPrint('girdi');
//  return test;

  }

}