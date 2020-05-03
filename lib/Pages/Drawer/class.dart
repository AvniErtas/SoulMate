import 'package:soulmate/Pages/Drawer/calendar.dart';
import 'package:soulmate/Pages/Drawer/mainpage.dart';
import 'package:soulmate/Pages/Drawer/settings.dart';
import 'package:soulmate/Pages/profile.dart';

import '../giris.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<GirisSayfasi>(() => GirisSayfasi());
    register<CalendarPage>(() => CalendarPage());
    register<SettingsPage>(() => SettingsPage());
    register<UserProfilePage>(() => UserProfilePage());

  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}