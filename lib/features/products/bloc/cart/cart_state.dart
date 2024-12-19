part of 'cart_bloc.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({
    required int quantity,
  }) = _CartState;
}
