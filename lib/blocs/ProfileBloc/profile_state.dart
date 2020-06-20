import 'package:equatable/equatable.dart';
import 'package:soulmate/model/user.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileUninitialized extends ProfileState {

}
class InitialProfileState extends ProfileState {}


class ProfileError extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;

  const ProfileLoaded({
    this.user,
  });

  ProfileLoaded copyWith({
    User user,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [user];

}