import 'dart:developer';

import 'package:oriflamenepal/core/dio/dio_manager.dart';
import 'package:oriflamenepal/features/products/models/all_products_model/all_products_model.dart';
import 'package:oriflamenepal/features/products/models/product_detail/product_detail_model.dart';

class ProductRepository {
  final DioManager dioManager;
  ProductRepository({required this.dioManager});

  Future<AllProductData?> fetchProducts({required int page }) async {
    try {
      final response = await dioManager.dio
          .get("/product", queryParameters: {"page": page, "limit": 10});
      if (response.statusCode == 200) {
        return AllProductData.fromJson(response.data["data"]);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductDetailData?> getproductDetail({required String slug}) async {
    try {
      final response = await dioManager.dio.get("/product/for-public/$slug");
      if (response.statusCode == 200) {
        return ProductDetailData.fromJson(response.data["data"]);
      }
      return null;
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      rethrow;
    }
  }
}
