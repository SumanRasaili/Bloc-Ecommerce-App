import 'package:get_it/get_it.dart';
import 'package:oriflamenepal/core/dio/dio_manager.dart';

final GetIt _getIt = GetIt.instance;

class ServiceLocator {
  static void init() {
    _getIt.registerSingleton<DioManager>(DioManager());
  }
}
