import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:soulmate/data/test_repository.dart';
import 'package:soulmate/model/test.dart';
import 'bloc.dart';
import '../locator.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final TestRepository testRepository = locator<TestRepository>();

  @override
  // TODO: implement initialState
  TestState get initialState => TestUninitialized();

  @override
  Stream<TestState> mapEventToState(
    TestEvent event,
  ) async* {
    yield TestLoading();
    if (event is FetchPopulerEvent) {
      try {
        List<Test> getirilenTest = testRepository.getPopulerTest();
        yield TestLoaded(Tests: getirilenTest);
      } catch (_) {
        yield TestError();
      }
    } else if (event is FetchKategoriEvent) {
      try {
        List<Test> getirilenTest = testRepository.getKategoriTest();
        yield TestLoaded(Tests: getirilenTest);
      } catch (_) {
        yield TestError();
      }
    }
    else if (event is FetchSonucEvent) {
      try {
        List<Test> getirilenTest = testRepository.getSonucTestler("uid");
        yield TestLoaded(Tests: getirilenTest);
      } catch (_) {
        yield TestError();
      }
    }
    else if (event is FetchKesfetEvent) {
      try {
        List<Test> getirilenTest = testRepository.getKesfetTestler();
        yield TestLoaded(Tests: getirilenTest);
      } catch (_) {
        yield TestError();
      }
    }
    else if (event is FetchTestFromIdEvent) {
      try {
        List<Test> getirilenTest = testRepository.getTestFromId("id");
        yield TestLoaded(Tests: getirilenTest);
      } catch (_) {
        yield TestError();
      }
    }
  }
}
