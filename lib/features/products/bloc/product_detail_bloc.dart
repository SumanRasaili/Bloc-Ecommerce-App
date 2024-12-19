import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oriflamenepal/features/products/models/product_detail/product_detail_model.dart';
import 'package:oriflamenepal/features/products/repository/product_repository.dart';

part 'product_detail_bloc.freezed.dart';
part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository productRepository;
  ProductDetailBloc({required this.productRepository})
      : super(const ProductDetailState.initial()) {
    on<ProductDetailEvent>((event, emit) async {
      await event.map(
        getProductDetail: (value) async {
          emit(const ProductDetailState.loading());
          try {
            final response =
                await productRepository.getproductDetail(slug: value.slug);

            if (response != null) {
              final initialColor = (response.colorAttributes.isNotEmpty)
                  ? response.colorAttributes.first.name ?? ""
                  : "";
              final colorVariants = (response.colorVariants.isNotEmpty)
                  ? response.colorVariants.firstWhere(
                      (e) => (e.color?.name ?? "") == initialColor,
                      orElse: () => const ColorVariant(),
                    )
                  : const ColorVariant();
              emit(
                ProductDetailState.loaded(
                  productDetailData: response,
                  selectedColor: initialColor,
                  colorVariant: colorVariants,
                ),
              );
            } else {
              emit(const ProductDetailState.error("Something went wrong"));
            }
          } catch (e, stackTrace) {
            log(stackTrace.toString());
            emit(ProductDetailState.error(e.toString()));
          }
        },
        toggleColorAttribute: (value) {
          state.maybeWhen(orElse: () {
            emit(const ProductDetailState.error("Product detail not loaded"));
          }, loaded: (
            productDetailData,
            String selectedColorAttribute,
            ColorVariant colorVariant,
          ) {
            emit(ProductDetailState.loaded(
              productDetailData: productDetailData,
              selectedColor: value.colorName,
              colorVariant: productDetailData.colorVariants.firstWhere(
                (e) => (e.color?.name ?? "") == value.colorName,
                orElse: () => const ColorVariant(),
              ),
            ));
          });
        },
      );
    });
  }
}
