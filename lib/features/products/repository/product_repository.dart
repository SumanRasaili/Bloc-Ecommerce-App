import 'dart:developer';

import 'package:oriflamenepal/core/dio/dio_manager.dart';
import 'package:oriflamenepal/core/service_locator/serv_locator.dart';
import 'package:oriflamenepal/features/products/models/all_products_model/all_products_model.dart';

class ProductRepository {
  final dioManager = serviceLocator<DioManager>();
  Future<AllProductData?> fetchProducts() async {
    try {
      final response = await dioManager.dio.get("/products");

      return response.data["data"];
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
