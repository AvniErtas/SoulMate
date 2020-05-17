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

    if(event is FetchPopulerEvent) {

      yield TestLoading();
      try{

        List<Test> getirilenTest = testRepository.getPopulerTest();
        yield TestLoaded(Tests: getirilenTest);
      }catch(_){
      yield TestError();
      }


    } else if(event is FetchKategoriEvent) {

      yield TestLoading();
      try{

        List<Test> getirilenTest = testRepository.getKategoriTest();
        yield TestLoaded(Tests: getirilenTest);
      }catch(_){
        yield TestError();
      }


    }

  }
}
