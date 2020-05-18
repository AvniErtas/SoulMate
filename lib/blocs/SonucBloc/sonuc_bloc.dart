import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:soulmate/data/anasayfa_repository.dart';
import 'package:soulmate/data/sonuc_repository.dart';
import 'package:soulmate/data/test_repository.dart';
import 'package:soulmate/model/test.dart';
import 'package:soulmate/model/user.dart';
import 'bloc.dart';
import '../locator.dart';

class SonucBloc extends Bloc<SonucEvent, SonucState> {
  final SonucRepository sonucRepository = locator<SonucRepository>();

  @override
  // TODO: implement initialState
  SonucState get initialState => SonucUninitialized();

  @override
  Stream<SonucState> mapEventToState(
      SonucEvent event,
  ) async* {
    if (event is FetchSonucEvent) {
      yield SonucLoading();
      try {
        List<User>  getirilenUsers = sonucRepository.getUserResults();
        yield SonucLoaded(users: getirilenUsers);
      } catch (_) {
        yield SonucError();
      }
    }
  }
}
