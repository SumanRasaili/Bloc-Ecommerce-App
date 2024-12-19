part of 'product_detail_bloc.dart';

@freezed
class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState.initial() = _Initial;
  const factory ProductDetailState.loading() = _Loading;
  const factory ProductDetailState.loaded(
      ProductDetailData productDetailData) = _Loaded;
  const factory ProductDetailState.error(String message) = _Error;
}
