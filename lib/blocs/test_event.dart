import 'package:equatable/equatable.dart';

abstract class TestEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchEvent extends TestEvent {

}

class InitalEvent extends TestEvent {

}