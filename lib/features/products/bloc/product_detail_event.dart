part of 'product_detail_bloc.dart';

@freezed
class ProductDetailEvent with _$ProductDetailEvent {
  const factory ProductDetailEvent.getProductDetail({required String slug}) =
      _GetProductDetail;
}
