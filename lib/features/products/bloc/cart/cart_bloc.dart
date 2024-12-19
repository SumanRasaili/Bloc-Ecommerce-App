import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_bloc.freezed.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(quantity: 1)) {
    on<CartEvent>((event, emit) {
      event.map(incrementQuantity: (value) {
        emit(state.copyWith(quantity: state.quantity + 1));
      }, decrementQuantity: (value) {
        emit(state.copyWith(quantity: state.quantity - 1));
      });
    });
  }
}
