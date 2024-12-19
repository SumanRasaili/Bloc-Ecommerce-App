part of 'products_bloc.dart';

@freezed
class ProductsBlocEvent with _$ProductsBlocEvent {
  const factory ProductsBlocEvent.fetchAllProducts() = _FetchAllProducts;
}
