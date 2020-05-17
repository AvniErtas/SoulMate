import 'package:equatable/equatable.dart';

abstract class TestEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPopulerEvent extends TestEvent {

}

class FetchKategoriEvent extends TestEvent {

}