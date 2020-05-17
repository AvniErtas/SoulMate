
import 'package:get_it/get_it.dart';
import 'package:soulmate/Pages/Drawer/class.dart';
import 'package:soulmate/data/test_repository.dart';

final GetIt locator= GetIt.instance;

void setupLocator(){

  locator.registerLazySingleton(() => TestRepository());
  ClassBuilder.registerClasses();
}
