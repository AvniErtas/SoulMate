import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:soulmate/Tools/domain.dart';
import 'package:soulmate/data/user_repository.dart';
import 'package:soulmate/model/user.dart';

import 'user_search_event.dart';
import 'user_search_state.dart';
import 'package:http/http.dart' as http;

class UserSearchBloc extends Bloc<UserListEvent, UserSearchState> {
  @override
  UserSearchState get initialState => UserSearchState.initial();

  @override
  void onTransition(Transition<UserListEvent, UserSearchState> transition) {
    print(transition.toString());
  }

  @override
  Stream<UserSearchState> mapEventToState(UserListEvent event) async* {
    yield UserSearchState.loading();
    if(event is UserSearchEvent)
    try {
      List<User> users = await _getSearchResults(event.query);
      yield UserSearchState.success(users);
    } catch (_) {
      yield UserSearchState.error();
    }
    else if(event is UserListSearchEvent)
      try {
        List<User> users = await _getUserListResults(event.uid);
        yield UserSearchState.success(users);
      } catch (_) {
        yield UserSearchState.error();
      }
    else if(event is UserListSearchPrivateEvent)
      try {
        List<User> users = await _getSearchResultsPrivate(event.query);
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

  Future<List<User>> _getUserListResults(String uid) async {
    var response =
    await http.post(Domain().getDomainApi() + "/user/list", body: {
      "uid": uid,
    });
    if (response.statusCode == 200) {
      debugPrint('userList:: '+response.body);
      return (json.decode(response.body) as List)
          .map((tekGonderiMap) => User.fromJson(tekGonderiMap))
          .toList();


    } else {
//      debugPrint(response.statusCode.toString());
//      debugPrint(response.body);
      throw Exception('Failed to load post');
    }
  }

  Future<List<User>> _getSearchResultsPrivate(String query) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser _user = await _auth.currentUser();
    var response =
    await http.post(Domain().getDomainApi() + "/user/search/private", body: {
      "query": query,
      "uid": _user.uid,
    });
    if (response.statusCode == 200) {
      debugPrint('user:: '+response.body);
      return (json.decode(response.body) as List)
          .map((tekGonderiMap) => User.fromJson(tekGonderiMap))
          .toList();
    } else {
      throw Exception('Failed to load post');
    }
  }
}
