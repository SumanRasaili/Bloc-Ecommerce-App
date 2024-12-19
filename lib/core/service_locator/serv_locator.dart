import 'package:get_it/get_it.dart';
import 'package:oriflamenepal/core/dio/dio_manager.dart';
import 'package:oriflamenepal/features/products/repository/product_repository.dart';

final GetIt serviceLocator = GetIt.instance;

class ServiceLocator {
  void init() {
    //dio
    serviceLocator.registerSingleton<DioManager>(DioManager());
    //repository
    serviceLocator.registerSingleton<ProductRepository>(ProductRepository());
  }
}
