// Flutter code sample for CheckboxListTile

// ![CheckboxListTile sample](https://flutter.github.io/assets-for-api-docs/assets/material/checkbox_list_tile.png)
//
// This widget shows a checkbox that, when checked, slows down all animations
// (including the animation of the checkbox itself getting checked!).
//
// This sample requires that you also import 'package:flutter/scheduler.dart',
// so that you can reference [timeDilation].

import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/Tools/progressDialog.dart';
import 'package:soulmate/Widgets/userPaylasmaSearch.dart';
import 'package:soulmate/blocs/UserSearchBloc/bloc.dart';
import 'package:soulmate/data/paylasim_repository.dart';
import 'package:soulmate/data/user_repository.dart';
import 'package:soulmate/model/user.dart';

/// This Widget is the main application widget.
class ArkadasListesiPaylasim extends StatefulWidget {
  static const String _title = 'Flutter Code Sample';
  String paylasimId;
  ArkadasListesiPaylasim(this.paylasimId);
  @override
  _ArkadasListesiPaylasimState createState() => _ArkadasListesiPaylasimState();
}

class _ArkadasListesiPaylasimState extends State<ArkadasListesiPaylasim> {
  UserSearchBloc userBloc;
  List<bool> liste;
  final globalKey = GlobalKey<ScaffoldState>();
  List<String> secilenKisiler = new List<String>();
  @override
  void initState() {
    liste = List<bool>.generate(0, (counter) => false);
    UserRepository userRepository =
        Provider.of<UserRepository>(context, listen: false);
    userBloc = BlocProvider.of<UserSearchBloc>(context);
    userBloc.add(UserListSearchEvent(userRepository.user.uid));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: const Text("Arkadaşlarım"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final User selectedUser = await showSearch(
                  context: context,
                  delegate: UserPaylasmaSearch(
                      BlocProvider.of<UserSearchBloc>(context)));
              globalKey.currentState.showSnackBar(SnackBar(
                content: Text(selectedUser.username + ' kişisi seçildi'),
              ));
            },
          )
        ],
      ),
      body: BlocBuilder<UserSearchBloc, UserSearchState>(
        bloc: userBloc,
        builder: (context, UserSearchState state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.hasError) {
            return Container(
              child: Text('Error'),
            );
          }
          if (liste.length == 0)
            liste = List<bool>.generate(state.users.length, (counter) => false);

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (contex, index) {
                      return Divider(
                        height: 20,
                        thickness: 2,
                        color: Colors.blue.shade100,
                      );
                    },
                    itemCount: state.users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CheckboxListTile(
                        title: Text(state.users[index].username),
                        value: liste[index],
                        onChanged: (bool value) {
                          setState(() {
                            timeDilation = value ? 2.0 : 1.0;
                            liste[index] = value;
                            if (value)
                              secilenKisiler.add(state.users[index].uid);
                            else
                              secilenKisiler.remove(state.users[index].uid);
                          });
                        },
                        secondary: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: FlutterLogo(size: 56.0),
                        ),
                      );
                    },
                  ),
                  bitir_buton(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget bitir_buton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: ButtonTheme(
          height: 25.0,
          child: FlatButton(
            onPressed: () => {
              bitir(),
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            color: Colors.cyan,
            child: Row(
              // Replace with a Row for horizontal icon + text
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 6),
                  child: Icon(
                    Icons.navigate_next,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Devam et",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void bitir() async {
    ProgressDialog pr = progressDialog(context);
    await pr.show();
    new PaylasimRepository()
        .kisiylePaylas(secilenKisiler, widget.paylasimId)
        .then((value) => {
              pr.hide().then((isHidden) {
                Navigator.pushReplacementNamed(context, '/PaylasmaSonrasi');
              })
            });
  }
}
