import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soulmate/Tools/domain.dart';
import 'package:soulmate/model/test.dart';
import 'package:http/http.dart' as http;

class AnaSayfaRepository {

  Future<List<List<Test>>> getAnaSayfaTest(int page) async {
    List< List<Test>> anasayfaTestler = new List< List<Test>>();
    List<Test> testlerPopuler = new List<Test>();
    List<Test> testlerEnCok = new List<Test>();

    var response =
        await http.post(Domain().getDomainApi() + "/test/popular", body: {
      "page": page,
    });
    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
      testlerPopuler = (json.decode(response.body) as List)
          .map((tekGonderiMap) => Test.fromJson(tekGonderiMap))
          .toList();
    } else {
      debugPrint(response.statusCode.toString());
    }

    var response2 =
    await http.post(Domain().getDomainApi() + "/test/enCokCozulen", body: {
      "page": page,
    });
    if (response2.statusCode == 200) {
      debugPrint(response2.body.toString());
      testlerEnCok = (json.decode(response2.body) as List)
          .map((tekGonderiMap) => Test.fromJson(tekGonderiMap))
          .toList();
    } else {
      debugPrint(response2.statusCode.toString());
    }
   /* testlerPopuler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test başlığxxxıdır 1 ???'));
    testlerPopuler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test soasdsdrusudur 2 ???'));
    testlerPopuler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorasdsadusudur 3 ???'));
    testlerPopuler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test soruddsudur 4 ???'));
    testlerPopuler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorucccsudur 5 ???'));


    testlerEnCok.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test kategorisd 1 ???'));
    testlerEnCok.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test axsx 2 ???'));
    testlerEnCok.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test xasaa 3 ???'));
    testlerEnCok.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test aaaa 4 ???'));
    testlerEnCok.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test xsdsd 5 ???'));
*/
    anasayfaTestler.add(testlerPopuler);
    anasayfaTestler.add(testlerEnCok);

    return anasayfaTestler;
  }



}