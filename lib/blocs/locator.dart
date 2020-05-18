
import 'package:get_it/get_it.dart';
import 'package:soulmate/Pages/Drawer/class.dart';
import 'package:soulmate/data/anasayfa_repository.dart';
import 'package:soulmate/data/sonuc_repository.dart';
import 'package:soulmate/data/test_repository.dart';

final GetIt locator= GetIt.instance;

void setupLocator(){

  locator.registerLazySingleton(() => TestRepository());
  locator.registerLazySingleton(() => AnaSayfaRepository());
  locator.registerLazySingleton(() => SonucRepository());
  ClassBuilder.registerClasses();
}
