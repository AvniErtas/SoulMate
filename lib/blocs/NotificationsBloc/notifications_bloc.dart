import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:soulmate/data/bildirim_repository.dart';
import 'package:soulmate/model/bildirim.dart';
import '../locator.dart';
import './bloc.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final BildirimRepository bildirimRepository = locator<BildirimRepository>();


  @override
  NotificationsState get initialState => InitialNotificationsState();

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    yield NotificationLoading();
    if (event is FetchNotificationEvent) {
      try {
        List<Bildirim> getirilenBildirim = await bildirimRepository.getBildirim();
        yield NotificationLoaded(bildirim: getirilenBildirim);
      } catch (_) {
        yield NotificationError();
      }
    }
  }
}
