import 'package:flutter/material.dart';
import 'package:soulmate/Colors/gradientcolor.dart';
import 'package:soulmate/Tools/kategoriResimleri.dart';
import 'package:soulmate/Widgets/Cards/gradientcard.dart';


class Testler extends StatefulWidget {

  String _testismi;
  Testler(this._testismi);

  @override
  _TestlerState createState() => _TestlerState();
}

class _TestlerState extends State<Testler> {
  String _selection;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double cardWidth = width * 0.2;
    double cardHeight = height * 0.15;
    return Scaffold(
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: cardHeight,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GradientCard(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              gradient: GradientColors.purplelove,
              child: Center(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: width*0.2,
                      height: height*0.08,
                      child: Image.asset(kategoriImageURL[index],
                          fit: BoxFit.contain),
                    ),
                  ),
                  title: Text(
                    'Lorem ipsum dolor sit amet, ante metus, in etiam diam.',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Soru Sayısı: 15',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  trailing: InkWell(
                    onTap: (){
                      debugPrint("asdas");
                      _showPopupMenu();
                    },
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  void _showPopupMenu() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: [
        PopupMenuItem<String>(
            child: const Text('Doge'), value: 'Doge'),
        PopupMenuItem<String>(
            child: const Text('Lion'), value: 'Lion'),
      ],
      elevation: 8.0,
    );
  }
  showPopUpMenu(){
    return PopupMenuButton<String>(
      onSelected: (String value) {
        setState(() {
          _selection = value;
        });
      },
      child: ListTile(
        leading: IconButton(
          icon: Icon(Icons.add_alarm),
          onPressed: () {
            print('Hello world');
          },
        ),
        title: Text('Title'),
        subtitle: Column(
          children: <Widget>[
            Text('Sub title'),
            Text(_selection == null ? 'Nothing selected yet' : _selection.toString()),
          ],
        ),
        trailing: Icon(Icons.account_circle),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Value1',
          child: Text('Choose value 1'),
        ),
        const PopupMenuItem<String>(
          value: 'Value2',
          child: Text('Choose value 2'),
        ),
        const PopupMenuItem<String>(
          value: 'Value3',
          child: Text('Choose value 3'),
        ),
      ],
    );
  }
}
