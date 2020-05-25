import 'package:flutter/material.dart';
import 'package:soulmate/Tools/kategoriResimleri.dart';

class FilterChipDisplay extends StatefulWidget {
  Function callback;

  FilterChipDisplay({Key key,this.callback}) : super(key: key);
  @override
  _FilterChipDisplayState createState() => _FilterChipDisplayState();
}

class _FilterChipDisplayState extends State<FilterChipDisplay> {
  List<int> secilenler = new List<int>();
  List<bool> isSecildi = new List<bool>(kategoriIsmi.length);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: Icon(
                Icons.close,
                size: 35,
                color: Colors.white,
              ))),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _titleContainer("Kategori seçiniz"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  child: Wrap(
                spacing: 5.0,
                runSpacing: 3.0,
                children: <Widget>[
                  for(int i=0 ; i<kategoriIsmi.length ; i++)
                    filterChipWidget(chipName: kategoriIsmi[i],index: i,callback: (index,isSelected) {
                      if(isSelected)
                        secilenler.add(index);
                      else secilenler.remove(index);
                    },),
                ],
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                debugPrint(secilenler.toString());
                widget.callback(secilenler);
                Navigator.pop(context);
              },
              color: Colors.green,
              child: Text(
                "Filtrele",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                new BorderRadius.circular(15.0),
              ),
            ),
          ),
        ],
      ),
    );

  }
  Widget filterChip (String chipName,int index) {
    var _isSelected = false;


    return FilterChip(
      label: Text(chipName),
      labelStyle: TextStyle(
          color: Color(0xff6200ee),
          fontSize: 16.0,
          fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          debugPrint("girdim amk "+index.toString());
          _isSelected = isSelected;
          if(isSelected)
          secilenler.add(index);
          else secilenler.remove(index);
        });
      },
      selectedColor: Color(0xffeadffd),
    );
  }
  }

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
  );
}

class filterChipWidget extends StatefulWidget {
  final String chipName;
  int index;
  Function callback;

  filterChipWidget({Key key, this.chipName, this.index,this.callback}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
          color: Color(0xff6200ee),
          fontSize: 16.0,
          fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          widget.callback(widget.index,isSelected);
        });
      },
      selectedColor: Color(0xffeadffd),
    );
  }
}
