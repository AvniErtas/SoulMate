import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soulmate/Tools/kategoriResimleri.dart';
import 'package:soulmate/blocs/UserSearchBloc/user_search_event.dart';
import 'package:soulmate/blocs/UserSearchBloc/user_search_state.dart';
import 'package:soulmate/model/user.dart';

class DataSearch extends SearchDelegate<User> {
  final Bloc<UserSearchEvent, UserSearchState> userBloc;

  DataSearch(this.userBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
      return _search();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _search();
  }

  Widget _search() {
    if(query.isNotEmpty)
   userBloc.add(UserSearchEvent(query));

    return BlocBuilder(
      bloc: userBloc,
      builder: (BuildContext context, UserSearchState state) {
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
              title: RichText(
                text: TextSpan(
                    text: state.users[index].username.substring(0, query.length),
                    style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: state.users[index].username.substring(query.length),
                          style: TextStyle(color: Colors.grey)),
                    ]),
              ),
              onTap: () => close(context, state.users[index]),
            );
          },
          itemCount: state.users.length,
        );
      },
    );
  }
}
