import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oriflamenepal/features/products/models/product_models.dart';

part 'products_bloc.freezed.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBlocBloc extends Bloc<ProductsBlocEvent, ProductsBlocState> {
  ProductsBlocBloc() : super(const ProductsBlocState.initial()) {
    on<ProductsBlocEvent>((event, emit) {
      event.map(
        fetchAllProducts: (value) => emit(const ProductsBlocState.loading()),
      );
    });
  }
}
