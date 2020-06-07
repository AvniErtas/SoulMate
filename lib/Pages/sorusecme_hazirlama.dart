import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/Tools/domain.dart';
import 'package:soulmate/Widgets/Cards/gradientcard.dart';
import 'package:soulmate/model/soru_hazirlama.dart';
import 'package:soulmate/model/sorular.dart';
import 'package:soulmate/model/test.dart';

class SoruSecmeVeHazirlama extends KFDrawerContent {
  @override
  _SoruSecmeVeHazirlamaState createState() => _SoruSecmeVeHazirlamaState();
}

class _SoruSecmeVeHazirlamaState extends State<SoruSecmeVeHazirlama> {
  double width;
  double height;
  List<double> animatedContainerSize = new List<double>(3);
  CarouselSlider slider;
  List<int> secilenSoruTipi =  List.generate(5, (i) => i+1);
  int soruNo = 0;
  List<TextEditingController> _soru_controller =
      List.generate(5, (i) => TextEditingController());
  List<List<String>> _soru_siklari = new List(5);
  String dropdownValue = 'Kategori Seçiniz';

  List <String> spinnerItems = [
    'Kategori Seçiniz',"Eğlence",'Kitap','İş','Film-Dizi','Gezi','Aile','Teknoloji','Yaşam Tarzı','Aşk','Yemek','Ahlaki İkiliem','Diğer'];
  @override
  void initState() {
    super.initState();
    animatedContainerSize[0] = 1;
    animatedContainerSize[1] = 1.5;
    animatedContainerSize[2] = 1;
   /* for (int i = 0; i < secilenSoruTipi.length; i++) {
      secilenSoruTipi[i] = 1; //default olarak abcd seçiyoruz
    }*/
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: GradientColors.Background1,
        ),
        child:  Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,70,20,0),
                  child: SizedBox(
                    height: height*0.07,
                    width: width*0.75,
                    child: TextFormField(
                      decoration: new InputDecoration(

                        labelStyle: TextStyle(color: Colors.white),
                        labelText: "Test adı giriniz",
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: new BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Kullanıcı adı boş olamaz!";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
                DropdownButton<String>(

                  value: dropdownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  underline: Container(
                    height: 2,
                    color: Colors.white,
                  ),
                  onChanged: (String data) {
                    setState(() {
                      dropdownValue = data;
                    });
                  },
                  items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: Colors.black),),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "İstediğin Soru Tipini Seç",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: height * 0.10 * 1.5,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height: height * 0.10 * animatedContainerSize[0],
                            width: height * 0.10 * animatedContainerSize[0],
                            decoration: new BoxDecoration(
                              image: DecorationImage(
                                image: new AssetImage(
                                    'images/digericonlar/percent.png'),
                                fit: BoxFit.contain,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              animatedContainerSize[0] = 1.5;
                              animatedContainerSize[1] = 1;
                              animatedContainerSize[2] = 1;
                              secilenSoruTipi[soruNo] = 0;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: //circleImages("abcd", "png"),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height: height * 0.10 * animatedContainerSize[1],
                            width: height * 0.10 * animatedContainerSize[1],
                            decoration: new BoxDecoration(
                              image: DecorationImage(
                                image: new AssetImage(
                                    'images/digericonlar/abcd.png'),
                                fit: BoxFit.contain,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              animatedContainerSize[1] = 1.5;
                              animatedContainerSize[0] = 1;
                              animatedContainerSize[2] = 1;
                              secilenSoruTipi[soruNo] = 1;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              animatedContainerSize[2] = 1.5;
                              animatedContainerSize[0] = 1;
                              animatedContainerSize[1] = 1;
                              secilenSoruTipi[soruNo] = 2;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height: height * 0.10 * animatedContainerSize[2],
                            width: height * 0.10 * animatedContainerSize[2],
                            decoration: new BoxDecoration(
                              image: DecorationImage(
                                image: new AssetImage(
                                    'images/digericonlar/evethayir3d.png'),
                                fit: BoxFit.contain,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sorunu Hazirla",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Slider(),

                ileriGeriButtons(),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    kaydet();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Hazırlamayı Bitir",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      height: height * 0.06,
                      width: width * 0.50,
                      decoration: BoxDecoration(
                        gradient: GradientColors.anasayfaswiper,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ileriGeriButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
        child: InkWell(
          onTap: () {
            slider.previousPage(
                duration: Duration(milliseconds: 300), curve: Curves.linear);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.050,
            width: MediaQuery.of(context).size.width * 0.25,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/digericonlar/onceki.png"),
              ),
            ),
          ),
        ),
      ),
      Flexible(
        child: InkWell(
          onTap: () {
//                  setState(() {
//                    index++;
//                  });
            slider.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.linear);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.050,
            width: MediaQuery.of(context).size.width * 0.25,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/digericonlar/sonraki.png"),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget Slider() {
    slider = CarouselSlider.builder(
      itemCount: 5,
      onPageChanged: (index) {
        setState(() {
          soruNo = index;
          switch (secilenSoruTipi[index]) {
            case 0:
              animatedContainerSize[0] = 1.5;
              animatedContainerSize[1] = 1;
              animatedContainerSize[2] = 1;
              break;
            case 1:
              animatedContainerSize[0] = 1;
              animatedContainerSize[1] = 1.5;
              animatedContainerSize[2] = 1;
              break;
            case 2:
              animatedContainerSize[0] = 1;
              animatedContainerSize[1] = 1;
              animatedContainerSize[2] = 1.5;
              break;
          }

          /*     animatedContainerSize[0] = 100.0;
              animatedContainerSize[1] = 100.0;
              if (siklar[index] != null) {
                animatedContainerSize[siklar[index]] = 150.0;
              }*/
        });
      },
      itemBuilder: (BuildContext context, int itemIndex) => GradientCard(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        gradient: GradientColors.sexyblue,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                decoration: new InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: "Sorunuzu Giriniz",
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                ),
                maxLength: 100,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                // onFieldSubmitted: (_) => FocusScope.of(globalKey.currentContext).nextFocus(),
                controller: _soru_controller[itemIndex],
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
            sikButton(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 20),
                  child: Text(
                    '${itemIndex + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return slider;
  }

  void _siklarDialog() {
    List<TextEditingController> _sik_controller =
        List.generate(4, (i) => TextEditingController());
    if (_soru_siklari[soruNo] != null) {
      _sik_controller[0].text = _soru_siklari[soruNo][0];
      _sik_controller[1].text = _soru_siklari[soruNo][1];
      _sik_controller[2].text = _soru_siklari[soruNo][2];
      _sik_controller[3].text = _soru_siklari[soruNo][3];
    }

    showDialog(
      context: context,
      builder: (BuildContext context_alert) {
        return AlertDialog(
          title: new Text("Şıkları giriniz"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "Şık 1",
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                  ),
                  maxLength: 100,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  // onFieldSubmitted: (_) => FocusScope.of(globalKey.currentContext).nextFocus(),
                  controller: _sik_controller[0],
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "Şık 2",
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                  ),
                  maxLength: 100,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  // onFieldSubmitted: (_) => FocusScope.of(globalKey.currentContext).nextFocus(),
                  controller: _sik_controller[1],
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "Şık 3",
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                  ),
                  maxLength: 100,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  // onFieldSubmitted: (_) => FocusScope.of(globalKey.currentContext).nextFocus(),
                  controller: _sik_controller[2],
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "Şık 4",
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                  ),
                  maxLength: 100,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  // onFieldSubmitted: (_) => FocusScope.of(globalKey.currentContext).nextFocus(),
                  controller: _sik_controller[3],
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("İptal"),
              onPressed: () {
                Navigator.of(context_alert).pop();
                //Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            new FlatButton(
              child: new Text("Tamam"),
              onPressed: () {
                bool isEmpty=false;
                List<String> _siklar = new List(4);
                _siklar[0] = _sik_controller[0].text;
                _siklar[1] = _sik_controller[1].text;
                _siklar[2] = _sik_controller[2].text;
                _siklar[3] = _sik_controller[3].text;
                _siklar.forEach((f) {
                  if (f.isEmpty) {
                    isEmpty = true;
                  }
                });

                if(isEmpty)
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text("Şıklar boş olamaz"),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Tamam"),
                            onPressed: () {
                              Navigator.of(context_alert).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                else {
                  setState(() {
                    _soru_siklari[soruNo] = _siklar;
                  });
                  Navigator.of(context_alert).pop();
                  klavyeKapat();
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Şıklar kaydedildi",
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight:
                        FontWeight.bold),), duration: Duration(seconds: 2), backgroundColor: Colors.blueAccent,)
                  );
//                  Navigator.of(context_alert).popUntil((route) => route.isFirst);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget circleImages(String title, String uzanti) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
      height: animatedContainerSize[0],
      width: animatedContainerSize[0],
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: new AssetImage('images/digericonlar/$title.$uzanti'),
          fit: BoxFit.contain,
        ),
        shape: BoxShape.circle,
      ),
    );
  }

  void kaydet() {
    bool hasNull = false;

    for(int i=0;i<_soru_controller.length;i++){
      if(_soru_controller[i].text.isNotEmpty){
        if(secilenSoruTipi[i]==1)
       if(_soru_siklari[i]==null) {
         showEmptyDialog(i);
         hasNull = true;
         break;
       }
      }
    }

    if (!hasNull)
      showBitirmeDialog();

    /* for (int i = 0; i < soru_sayisi; i++) {
      if(_soru_controller[i].text.isNotEmpty) {
        String soru;
        List<String> siklar;
        int soru_tipi = secilenSoruTipi[i];
        if(soru_tipi == 1) {
          if(_soru_siklari[i] != null){
            soru = _soru_controller[i].text;
            siklar = _soru_siklari[i];
            ///soru,şıklar ve soru tipi alındı model oluşturup sunucuya kaydet
          }else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Şıklı soru tipindeki sorularda şıklar boş olamaz (${i+1}.soru)"),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("Tamam"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            break;
          }
        }else {
          soru = _soru_controller[i].text;
          ///soru,şıklar ve soru tipi alındı model oluşturup sunucuya kaydet
        }

      }

    }*/
  }

  showEmptyDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Test sorularındaki şıkları doldurmalısınız!"),
          content: new Text('${index+1}.sorunun şıkları boş'),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showBitirmeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Hazırlamayı bitirmek istiyor musunuz?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Hayır"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
                child: new Text("Evet"),
                onPressed: () {
                  List<Sorular> sorularList = new List<Sorular>();
                  // TODO soruHazirlama objesini sunucuya kaydet
                  for(int i=0;i<_soru_controller.length;i++){
                    if(_soru_controller[i].text.isNotEmpty)
                    sorularList.add(new Sorular(soru: _soru_controller[i].text,siklar: _soru_siklari[i],soruTipi: secilenSoruTipi[i]));
                  }
                  Test test = new Test(kategori: 'ask',olusturanTipi: 'Uye',olusturanUid: 'uid_test',testAdi: 'test_adix',sorular: sorularList);

                  sorularList.forEach((item){
                      debugPrint(item.toString());
                  });
                  uploadTest(test);
                  Navigator.of(context).pop();
                  klavyeKapat();
                }),
          ],
        );
      },
    );
  }
  void uploadTest(Test test) async {
  /*  var dio = Dio();
    FormData formData = FormData.fromMap({
      "fromID": testToJson(test),
      "file": await MultipartFile.fromFile(widget.image.path),
    });
    Response response = await dio.post(
      Domain().getDomainApi() + "/post/uploadFile",
      data: formData,
   
    );
    debugPrint(response.toString());*/
  }

  sikButton() {
    if (secilenSoruTipi[soruNo] == 1 ? true : false)
      return RaisedButton.icon(
        icon:
            _soru_siklari[soruNo] != null ? Icon(Icons.done) : Icon(Icons.add),
        onPressed: () {
          _siklarDialog();
        },
        color: Colors.green,
        label: Text(
          "Şıkları oluşturmak için tıkla",
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
        ),
      );
    else
      return Container();
  }

  void klavyeKapat() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
