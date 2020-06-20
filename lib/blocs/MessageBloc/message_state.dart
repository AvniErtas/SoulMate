import 'package:equatable/equatable.dart';
import 'package:soulmate/Pages/message/message_model.dart';
import 'package:soulmate/model/user.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageUninitialized extends MessageState {
  
}
class InitialMessageState extends MessageState {}


class MessageError extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final Message message;

  const MessageLoaded({
    this.message,
  });

  MessageLoaded copyWith({
    Message message,
  }) {
    return MessageLoaded(
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [message];

}