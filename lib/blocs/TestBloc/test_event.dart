import 'package:equatable/equatable.dart';

abstract class TestEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPopulerEvent extends TestEvent {}

class FetchKategoriEvent extends TestEvent {}

class FetchSonucEvent extends TestEvent {}

class FetchKesfetEvent extends TestEvent {}

class FetchTestFromIdEvent extends TestEvent {
  String testId;

  FetchTestFromIdEvent(this.testId);
}
