import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:soulmate/data/profile_repository.dart';
import 'package:soulmate/model/user.dart';
import 'bloc.dart';
import '../locator.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository = locator<ProfileRepository>();

  @override
  // TODO: implement initialState
  ProfileState get initialState => ProfileUninitialized();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    yield ProfileLoading();
    if (event is FetchUserFromUidEvent) {
      try {
        User getirilenProfile = await profileRepository.getUser(event.uid);
        yield ProfileLoaded(user: getirilenProfile);
      } catch (_) {
        yield ProfileError();
      }
    }
  }
}
