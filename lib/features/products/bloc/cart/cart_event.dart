part of 'cart_bloc.dart';
@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.incrementQuantity(int quantity) = _IncrementQuantity;
  const factory CartEvent.decrementQuantity(int  quantity) = _DecrementQuantity;
}