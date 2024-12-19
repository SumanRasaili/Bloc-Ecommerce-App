import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oriflamenepal/core/service_locator/serv_locator.dart';
import 'package:oriflamenepal/features/products/models/all_products_model/all_products_model.dart';
import 'package:oriflamenepal/features/products/repository/product_repository.dart';

part 'products_bloc.freezed.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsBlocEvent, ProductsBlocState> {
  ProductsBloc() : super(const ProductsBlocState.initial()) {
    final productRepo = serviceLocator<ProductRepository>();
    on<ProductsBlocEvent>(
      (event, emit) async {
        event.map(
          fetchAllProducts: (value) async {
            emit(
              const ProductsBlocState.loading(),
            );
            try {
              AllProductData? productResponse =
                  await productRepo.fetchProducts();
              if (productResponse != null) {
                emit(ProductsBlocState.loaded(productResponse));
              } else {
                emit(const ProductsBlocState.error("No Products Found !"));
              }
            } catch (e) {
              emit(ProductsBlocState.error(e.toString()));
            }
          },
        );
      },
    );
  }
}
