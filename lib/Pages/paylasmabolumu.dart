import 'package:flutter/material.dart';

class PaylasmaBolumu extends StatelessWidget {
  double width;
  double height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(child: circleImages("arkilepaylas")),
            InkWell(child: circleImages("KesfettePaylas")),
            InkWell(
              onTap: () {},
              child: Row(
                children: <Widget>[
                  Container(
                    height: height * 0.25,
                    width: width * 0.33,
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image:
                            new AssetImage('images/digericonlar/facebook.png'),
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: height * 0.25,
                    width: width * 0.33,
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image:
                            new AssetImage('images/digericonlar/instagram.png'),
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: height * 0.25,
                    width: width * 0.33,
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image:
                            new AssetImage('images/digericonlar/whatsapp.png'),
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget circleImages(String title) {
    return Container(
      height: height * 0.25,
      width: width * 0.4,
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: new AssetImage('images/secimresimleri/$title.png'),
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
