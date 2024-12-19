import 'dart:developer';

import 'package:oriflamenepal/core/dio/dio_manager.dart';
import 'package:oriflamenepal/features/products/models/all_products_model/all_products_model.dart';
import 'package:oriflamenepal/features/products/models/product_detail/product_detail_model.dart';

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

  Future<ProductDetailModel?> getproductDetail({required String slug}) async {
    try {
      final response = await dioManager.dio.get("/product/for-public/$slug");
      if (response.statusCode == 200) {
        try {
          return ProductDetailModel.fromJson(response.data["data"]);
        } catch (e, stackTrace) {
          log(stackTrace.toString());
        }
      }
      return null;
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      rethrow;
    }
  }
}
