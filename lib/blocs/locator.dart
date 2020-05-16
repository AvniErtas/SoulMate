
import 'package:get_it/get_it.dart';
import 'package:soulmate/data/test_repository.dart';

GetIt locator= GetIt.instance();

void setupLocator(){
  locator.registerLazySingleton(() => TestRepository);
}
