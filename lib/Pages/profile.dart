import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:soulmate/Tools/domain.dart';
import 'package:soulmate/Widgets/Cards/CardDesingTests.dart';
import 'package:soulmate/data/user_repository.dart';
import 'package:soulmate/model/test.dart';
import 'dart:io';

class UserProfilePage extends StatefulWidget {
  VoidCallback _returnMainWidget;

  UserProfilePage(Key k, this._returnMainWidget) : super(key: k);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  final String _fullName = "Nick Frost";
  final String _status = "Software Developer";
  final String _bio =
      "\"Hi, I am a Freelance developer working for hourly basis. If you wants to contact me to build your product leave a message.\"";
  final String _followers = "173";
  final String _posts = "24";
  final String _scores = "450";

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  String uid;
  File _imageFile;
  final globalKey = GlobalKey<ScaffoldState>();
  final ImagePicker _picker = ImagePicker();

  AnimationController animationController;
  Animation degOneTranslationAnimation;
  Animation rotationAnimation;

  double heightMedia;
  List<Test> testler = new List<Test>();

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/backg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Center(
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl:  Domain().getDomainApi()+'/user/getThumbnail?uid=$uid',
            imageBuilder: (context, imageProvider) => Container(
              width: width * 0.3,
              height: width * 0.3,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: width * 0.01,
                ),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: imageProvider, fit: BoxFit.cover),
              ),

            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),


        /*  Container(
            width: width * 0.3,
            height: width * 0.3,
            decoration: BoxDecoration(
              image: CachedNetworkImage(
                imageUrl: "http://via.placeholder.com/350x150",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),

              borderRadius: BorderRadius.circular(80.0),
              border: Border.all(
                color: Colors.white,
                width: width * 0.01,
              ),
            ),
          ),*/
          Transform.translate(
            offset: Offset.fromDirection(getRadiansFromDegree(180),
                degOneTranslationAnimation.value * 35),
            child: Transform(
              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degOneTranslationAnimation.value),
              alignment: Alignment.center,
              child: ClipOval(
                child: Material(
                  color: Colors.transparent, // button color
                  child: Opacity(
                    opacity: degOneTranslationAnimation.value,
                    child: IconButton(icon: Icon(Icons.photo),onPressed:() async => await _pickImageFromGallery(),),
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset.fromDirection(getRadiansFromDegree(270),
                degOneTranslationAnimation.value * 35),
            child: Transform(
              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degOneTranslationAnimation.value),
              alignment: Alignment.center,
              child: ClipOval(
                child: Material(
                  color: Colors.transparent, // button color
                  child: Opacity(
                    opacity: degOneTranslationAnimation.value,
                    child: IconButton(
                      onPressed: (){
                          debugPrint("ASDASD");
                      },
                      icon: Icon(Icons.photo_camera,),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Transform(
            transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value*2)),
            alignment: Alignment.center,
            child: ClipOval(
              child: Material(
                color: Colors.transparent, // button color
                child: InkWell(
                  splashColor: Colors.indigo, // inkwell color
                  child: SizedBox(width: 25, height: 25, child: Icon(Icons.edit,color: Colors.black,)),
                  onTap: () {
                    if (animationController.isCompleted) {
                      animationController.reverse();
                    } else {
                      animationController.forward();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _pickImageFromGallery() async {
    final imageFile = await _picker.getImage(source: ImageSource.gallery);
    final File file = File(imageFile.path);
    setState(() => this._imageFile = file);
  }

  Future<Null> _pickImageFromCamera() async {
    final imageFile =
    await _picker.getImage(source: ImageSource.camera, imageQuality: 85);
    final File file = File(imageFile.path);
    setState(() => this._imageFile = file);
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    );

    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 15.0,
      fontWeight: FontWeight.w400,
    );

    TextStyle _statCountTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Test Sayısı", _followers),
          _buildStatItem("Arkadaş", _posts),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      //color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Get in Touch with ${_fullName.split(" ")[0]},",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }

  Widget _buildButtons() {
    // TODO Butonlar değiştirilecek
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => print("followed"),
              child: Container(
                height: height * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    "ARKADAŞ EKLE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => print("Message"),
              child: Container(
                height: height * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "MESAJ GÖNDER",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    testler.add(new Test(
        id: '123',
        olusturanUid: '124',
        olusturanTipi: 'Ekip',
        kategori: 'Aşk',
        olusturmaTarihi: "11111",
        testAdi: 'Bu bir test sorusudur XX ???'));
    testler.add(new Test(
        id: '123',
        olusturanUid: '124',
        olusturanTipi: 'Ekip',
        kategori: 'Aşk',
        olusturmaTarihi: "11111",
        testAdi: 'Bu bir test sorusudur XX ???'));
    testler.add(new Test(
        id: '123',
        olusturanUid: '124',
        olusturanTipi: 'Ekip',
        kategori: 'Aşk',
        olusturmaTarihi: "11111",
        testAdi: 'Bu bir test sorusudur XX ???'));
    testler.add(new Test(
        id: '123',
        olusturanUid: '124',
        olusturanTipi: 'Ekip',
        kategori: 'Aşk',
        olusturmaTarihi: "11111",
        testAdi: 'Bu bir test sorusudur XX ???'));
    testler.add(new Test(
        id: '123',
        olusturanUid: '124',
        olusturanTipi: 'Ekip',
        kategori: 'Aşk',
        olusturmaTarihi: "11111",
        testAdi: 'Bu bir test sorusudur XX ???'));

    //Profile edit için animasyon ayarı

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0,end:0.0).animate(CurvedAnimation(parent: animationController,curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      uid = Provider.of<UserRepository>(context).user.uid;
    });
    List<String> testAdi = new List<String>();
    for (Test test in testler) {
      testAdi.add(test.testAdi);
    }
    heightMedia = MediaQuery.of(context).size.height;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: screenSize.height / 10),
                    _buildProfileImage(),
                    _buildFullName(),
                    _buildStatus(context),
                    _buildStatContainer(),
                    // _buildBio(context),
                    _buildSeparator(screenSize),
                    SizedBox(height: 10.0),
                    //_buildGetInTouch(context),
                    SizedBox(height: 8.0),
                    _buildButtons(),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Son Çözülen Testler",
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                    SizedBox(height: 8.0),
                    cardDesingTests(
                        testVeSorular: testAdi, size: heightMedia / 280),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xff5287f7),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 00,
            left: 00,
            child: IconButton(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.white,
              ),
              onPressed: () {
                _showDialogExit();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDialogExit() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Çıkmak istediğinize emin misiniz ?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Hayır"),
              onPressed: () {
                Navigator.of(context).pop();
                //Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            new FlatButton(
              child: new Text("Evet"),
              onPressed: () {
                var userRepo =
                    Provider.of<UserRepository>(context, listen: false);
                userRepo.signOut();
                Navigator.of(context).pop();
                widget._returnMainWidget();
                // _signOut();
              },
            ),
          ],
        );
      },
    );
  }
}
