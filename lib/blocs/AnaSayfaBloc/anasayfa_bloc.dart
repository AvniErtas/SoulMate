import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:soulmate/data/anasayfa_repository.dart';
import 'package:soulmate/data/test_repository.dart';
import 'package:soulmate/model/test.dart';
import 'bloc.dart';
import '../locator.dart';

class AnaSayfaBloc extends Bloc<AnaSayfaEvent, AnaSayfaState> {
  final AnaSayfaRepository anaSayfaRepository = locator<AnaSayfaRepository>();

  @override
  // TODO: implement initialState
  AnaSayfaState get initialState => AnaSayfaUninitialized();

  @override
  Stream<AnaSayfaState> mapEventToState(
      AnaSayfaEvent event,
  ) async* {
    if (event is FetchAnaSayfaEvent) {
      yield AnaSayfaLoading();
      try {
        List<List<Test>>  getirilenTest = await anaSayfaRepository.getAnaSayfaTest(0);
        yield AnaSayfaLoaded(Tests: getirilenTest);
      } catch (e) {
        print(e);
        yield AnaSayfaError();
      }
    }
  }
}
