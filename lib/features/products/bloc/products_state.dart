part of 'products_bloc.dart';

@freezed
class ProductsBlocState with _$ProductsBlocState {
  const factory ProductsBlocState.initial() = _Initial;
  const factory ProductsBlocState.loading() = _Loading;
  const factory ProductsBlocState.loaded(List<Doc> docs, bool hasMore,
      int currentPage, bool paginationLoading) = _Loaded;
  const factory ProductsBlocState.error(String message) = _Error;
}
