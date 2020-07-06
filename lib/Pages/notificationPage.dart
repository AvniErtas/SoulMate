import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/Tools/bildirimKodlari.dart';
import 'package:soulmate/Tools/kategoriResimleri.dart';
import 'package:soulmate/Widgets/circleCategory.dart';
import 'package:soulmate/blocs/NotificationsBloc/notifications_bloc.dart';
import 'package:soulmate/blocs/NotificationsBloc/notifications_event.dart';
import 'package:soulmate/blocs/NotificationsBloc/notifications_state.dart';
import 'package:soulmate/blocs/ProfileBloc/profile_bloc.dart';

import 'profile.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationsBloc _notificationsBloc;
  bool isTest = false;
  List<bool> liste = List<bool>();
  List<String> userID = ["Ayşe", "Fatma", "Hayriye"];

  List<String> bildirimler = [
    "Mehmet sana Arkadaşlık isteği gönderdi",
    "Ailene Ne Kadar Düşkünsün Testini Çözdü",
  ];

  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < 10; i++) {
      liste.add(false);
    }
    _notificationsBloc = BlocProvider.of<NotificationsBloc>(context);
    _notificationsBloc.add(FetchNotificationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTasarim2(title : "Bildirimler",),

      body: BlocBuilder<NotificationsBloc, NotificationsState>(
          bloc: _notificationsBloc,
          builder: (context, NotificationsState state) {
            debugPrint(state.toString());
            if (state is NotificationUninitialized) {
              return Text("UNINIT");
            } else if (state is NotificationLoading) {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            }
            else if (state is NotificationLoaded) {
             return ListView.separated(
                separatorBuilder: (context, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.blueGrey,
                  height: 1.2,

                ),
                itemCount: state.bildirim.length,
                itemBuilder: (BuildContext context, int index) {
                  String gelenBildirim = new BildirimHazirla().getBildirim(state.bildirim[index].bildirimID, state.bildirim[index].gonderenAdi);
                  return ListTile(
                    onTap: (){
                      if(state.bildirim[index].bildirimID == arkadasEkle) {
                        var router = new MaterialPageRoute(
                            builder: (BuildContext context) {
                              return BlocProvider<ProfileBloc>(
                                create: (BuildContext context) => ProfileBloc(),
                                child: UserProfilePage(
                                  uid: state.bildirim[index].gonderenUid,
                                ),
                              );
                            });
                        Navigator.of(context).push(router);
                      }
                    },
                    onLongPress: (){},
                    title: Text(gelenBildirim),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 60,
                        child:
                        Image.asset(kategoriImageURL[index], fit: BoxFit.contain),
                      ),
                    ),
                  );
                },
              );
            }
            else if (state is NotificationError) {
              return Text("İnternet yok amk");
            } else {
              return Text("state");
            }
          }),
    );
  }


  /*Widget imageWidget() {
    return Container(
      height: 60,
      width: 60,
      child: CircleAvatar(
        backgroundImage: AssetImage("assets/profile.jpeg"),
      ),
    );
  }*/

  /*Widget takipEtButton() {
    return RaisedButton(
      onPressed: () {},
      color: Colors.blue,
      child: Text(
        "Takip Et",
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
      elevation: 2,
    );
  }*/


}
