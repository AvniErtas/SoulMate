import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:soulmate/Pages/message/message_model.dart';
import 'package:soulmate/data/message_repository.dart';
import 'package:soulmate/model/user.dart';
import 'bloc.dart';
import '../locator.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository = locator<MessageRepository>();

  @override
  // TODO: implement initialState
  MessageState get initialState => MessageUninitialized();

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    yield MessageLoading();
    if (event is FetchMessageFromUidEvent) {
      try {
        Message getirilenMessage = await messageRepository.getMessage(event.uid);
        yield MessageLoaded(message: getirilenMessage);
      } catch (_) {
        yield MessageError();
      }
    }
  }
}
