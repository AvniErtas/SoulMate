import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soulmate/Tools/domain.dart';
import 'package:soulmate/model/user.dart';

import 'user_search_event.dart';
import 'user_search_state.dart';
import 'package:http/http.dart' as http;

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  @override
  UserSearchState get initialState => UserSearchState.initial();

  @override
  void onTransition(Transition<UserSearchEvent, UserSearchState> transition) {
    print(transition.toString());
  }

  @override
  Stream<UserSearchState> mapEventToState(UserSearchEvent event) async* {
    yield UserSearchState.loading();

    try {
      List<User> users = await _getSearchResults(event.query);
      yield UserSearchState.success(users);
    } catch (_) {
      yield UserSearchState.error();
    }
  }

  Future<List<User>> _getSearchResults(String query) async {
    var response =
        await http.post(Domain().getDomainApi() + "/user/search", body: {
      "query": query,
    });
    if (response.statusCode == 200) {
      debugPrint('user:: '+response.body);
      return (json.decode(response.body) as List)
          .map((tekGonderiMap) => User.fromJson(tekGonderiMap))
          .toList();


    } else {
//      debugPrint(response.statusCode.toString());
//      debugPrint(response.body);
      throw Exception('Failed to load post');
    }
  }
}
