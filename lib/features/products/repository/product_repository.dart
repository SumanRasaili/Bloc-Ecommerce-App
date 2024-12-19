import 'package:oriflamenepal/core/dio/dio_manager.dart';
import 'package:oriflamenepal/core/service_locator/serv_locator.dart';
import 'package:oriflamenepal/features/products/models/all_products_model/all_products_model.dart';

class ProductRepository {
  final DioManager dioManager;
  ProductRepository({required this.dioManager});

  Future<AllProductData?> fetchProducts() async {
    try {
      final response = await dioManager.dio.get("/product");
      if (response.statusCode == 200) {
        return AllProductData.fromJson(response.data["data"]);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
