import 'package:equatable/equatable.dart';

import 'package:soulmate/model/test.dart';
import 'package:soulmate/model/user.dart';

abstract class SonucState extends Equatable {
  const SonucState();

  @override
  List<Object> get props => [];
}

class SonucUninitialized extends SonucState {

}
class InitialSonucState extends SonucState {}


class SonucError extends SonucState {}

class SonucLoading extends SonucState {}

class SonucLoaded extends SonucState {
  final List<User> users;
  final bool hasReachedMax;

  const SonucLoaded({
    this.users,
    this.hasReachedMax,
  });

  SonucLoaded copyWith({
    List<User> users,
    bool hasReachedMax,
  }) {
    return SonucLoaded(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [users, hasReachedMax];

  @override
  String toString() =>
      'TestLoaded { Tests: ${users.length}, hasReachedMax: $hasReachedMax }';
}