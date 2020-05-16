import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:soulmate/data/test_repository.dart';
import 'package:soulmate/model/test.dart';
import './bloc.dart';
import 'locator.dart';

class TestBloc extends Bloc<TestEvent, TestState> {

  final TestRepository testRepository = locator<TestRepository>();


  @override
  // TODO: implement initialState
  TestState get initialState => null;

  @override
  Stream<TestState> mapEventToState(
    TestEvent event,
  ) async* {

    if(event is FetchEvent) {

      yield TestLoading();
      try{

        List<Test> getirilenTest = await testRepository.getTest();
        yield TestLoaded(Tests: getirilenTest );
      }catch(_){
      yield TestError();
      }


    }


  }
}
