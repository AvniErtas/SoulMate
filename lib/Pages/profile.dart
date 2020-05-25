import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/Widgets/Cards/CardDesingTests.dart';
import 'package:soulmate/Widgets/Cards/gradientcard.dart';
import 'package:soulmate/model/test.dart';

class UserProfilePage  extends KFDrawerContent {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final String _fullName = "Nick Frost";

  final String _status = "Software Developer";

  final String _bio =
      "\"Hi, I am a Freelance developer working for hourly basis. If you wants to contact me to build your product leave a message.\"";

  final String _followers = "173";

  final String _posts = "24";

  final String _scores = "450";

  double heightMedia;

  List<Test> testler = new List<Test>();
  
  

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/backg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: 140.0,
            height: 140.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/profile.jpeg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(80.0),
              border: Border.all(
                color: Colors.white,
                width: 10.0,
              ),
            ),
          ),
          InkWell(child: Icon(Icons.edit),onTap: (){},),
        ],
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
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
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    );

    TextStyle _statCountTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 24.0,
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
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Test Sayısı", _followers),
          _buildStatItem("Takipçi", _posts),
          _buildStatItem("Takip", _scores),
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => print("followed"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    "TAKİP ET",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
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
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "MESAJ GÖNDER",
                      style: TextStyle(fontWeight: FontWeight.w600),
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
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorusudur XX ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorusudur XX ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorusudur XX ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorusudur XX ???'));
    testler.add(new Test(id: '123',olusturanUid: '124',olusturanTipi: 'Ekip',kategori: 'Aşk',olusturmaTarihi: '22.02.2020',testAdi: 'Bu bir test sorusudur XX ???'));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<String> testAdi = new List<String>();
    for(Test test in  testler){
      testAdi.add(test.testAdi);
    }
    heightMedia = MediaQuery.of(context).size.height;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarTasarim(""), //appbar'ın en sağına ayarlar simgesi konulacak

      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(),
                  _buildFullName(),
                  _buildStatus(context),
                  _buildStatContainer(),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  _buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  _buildButtons(),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Son Çözülen Testler",
                          style: TextStyle(fontSize: 17,fontFamily: 'Roboto',fontWeight: FontWeight.w500),
                        )),
                  ),
                  SizedBox(height: 8.0),
                 cardDesingTests(testVeSorular: testAdi),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
