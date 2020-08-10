import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soulmate/Pages/profile.dart';
import 'package:soulmate/Tools/appbar.dart';
import 'package:soulmate/blocs/ProfileBloc/profile_bloc.dart';
import 'package:soulmate/blocs/UserSearchBloc/bloc.dart';

class UserList extends StatefulWidget {
  String uid;
  UserList(this.uid);
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    UserSearchBloc userBloc = BlocProvider.of<UserSearchBloc>(context);
    userBloc.add(UserListSearchEvent(widget.uid));
    return Scaffold(
      appBar: appBarTasarim2(title: 'Arkadaş Listesi'),
      body: BlocBuilder<UserSearchBloc,UserSearchState>(
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
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.person_outline),
                title: Text(state.users[index].username),
                onTap: () {
                  var router = new MaterialPageRoute(
                      builder: (BuildContext context){
                        return BlocProvider<ProfileBloc>(
                          create: (BuildContext context) =>   ProfileBloc(),
                          child:  UserProfilePage(
                            uid: state.users[index].uid,
                          ),
                        );
                      });
                  Navigator.of(context).push(router);
                },
              );
            },
            itemCount: state.users.length,
          );
        },
      ),
    );
  }
}
