import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oriflamenepal/features/products/models/all_products_model/all_products_model.dart';
import 'package:oriflamenepal/features/products/repository/product_repository.dart';

part 'products_bloc.freezed.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsBlocEvent, ProductsBlocState> {
  final ProductRepository productRepo;
  ProductsBloc(this.productRepo) : super(const ProductsBlocState.initial()) {
    on<ProductsBlocEvent>(
      (event, emit) async {
        await event.map(
          fetchAllProducts: (value) async {
            final currentState = state;
            if (currentState is! _Loaded || (currentState).hasMore) {
              if (currentState is _Loaded && (currentState).hasMore) {
                emit(currentState.copyWith(paginationLoading: true));
              } else {
                emit(const ProductsBlocState.loading());
              }
            }

            try {
              AllProductData? productResponse =
                  await productRepo.fetchProducts(page: value.page);
              final products = productResponse?.docs;
              final pagination = productResponse?.pagination;
              if (productResponse != null && productResponse.docs.isNotEmpty) {
                if (state is _Loaded) {
                  final currentState = state as _Loaded;
                  emit(
                    ProductsBlocState.loaded(
                      [...currentState.docs, ...products ?? []],
                      pagination?.nextPage ?? false,
                      pagination!.page!,
                      false,
                    ),
                  );
                } else {
                  emit(
                    ProductsBlocState.loaded(
                      products ?? [],
                      pagination?.nextPage ?? false,
                      pagination?.page ?? 1,
                      false,
                    ),
                  );
                }
              } else {
                emit(const ProductsBlocState.error("No Products Found !"));
              }
            } catch (e, stackTrace) {
              log(stackTrace.toString());
              emit(ProductsBlocState.error(e.toString()));
            }
          },
        );
      },
    );
  }
}
