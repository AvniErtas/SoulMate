import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMessageFromUidEvent extends MessageEvent {
  String uid;

  FetchMessageFromUidEvent(this.uid);
}
