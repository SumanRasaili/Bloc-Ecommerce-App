import 'package:get_it/get_it.dart';
import 'package:oriflamenepal/core/dio/dio_manager.dart';

final GetIt serviceLocator = GetIt.instance;

class ServiceLocator {
   void init() {
    serviceLocator.registerSingleton<DioManager>(DioManager());
  }
}
