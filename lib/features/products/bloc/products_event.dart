part of 'products_bloc.dart';

@freezed
class ProductsBlocEvent with _$ProductsBlocEvent {
  const factory ProductsBlocEvent.fetchAllProducts({required int page}) =
      _FetchAllProducts;
}
