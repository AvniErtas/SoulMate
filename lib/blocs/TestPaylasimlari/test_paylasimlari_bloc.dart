import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'test_paylasimlari_event.dart';
part 'test_paylasimlari_state.dart';

class TestPaylasimlariBloc extends Bloc<TestPaylasimlariEvent, TestPaylasimlariState> {
  final SonucRepository sonucRepository = locator<SonucRepository>();

  @override
  // TODO: implement initialState
  TestPaylasimlariState get initialState => TestPaylasimlariUninitialized();

  @override
  Stream<TestPaylasimlariState> mapEventToState(
    TestPaylasimlariEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
