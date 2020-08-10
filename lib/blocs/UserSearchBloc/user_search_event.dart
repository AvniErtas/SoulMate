
import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserSearchEvent extends UserListEvent{
  final String query;

  UserSearchEvent(this.query);

  @override
  String toString() => 'UserSearchEvent { query: $query }';
}

class UserListSearchEvent extends UserListEvent{
  final String uid;

  UserListSearchEvent(this.uid);

  @override
  String toString() => 'UserSearchEvent { uid: $uid }';
}

class UserListSearchPrivateEvent extends UserListEvent{
  final String query;

  UserListSearchPrivateEvent(this.query);
}

