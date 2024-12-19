// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_detail_model.freezed.dart';
part 'product_detail_model.g.dart';

@freezed
class ProductDetailModel with _$ProductDetailModel {
  const factory ProductDetailModel({
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "message") String? message,
    @JsonKey(name: "data") ProductDetailData? data,
  }) = _ProductDetailModel;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);
}

@freezed
class ProductDetailData with _$ProductDetailData {
  const factory ProductDetailData({
    @JsonKey(name: "_id") String? id,
    @JsonKey(name: "slug") String? slug,
    @JsonKey(name: "category") Category? category,
    @JsonKey(name: "brand") Brand? brand,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "ingredient") String? ingredient,
    @JsonKey(name: "howToUse") String? howToUse,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "commissionPercentage") int? commissionPercentage,
    @JsonKey(name: "strikePrice") int? strikePrice,
    @JsonKey(name: "offPercent") int? offPercent,
    @JsonKey(name: "minOrder") int? minOrder,
    @JsonKey(name: "maxOrder") int? maxOrder,
    @JsonKey(name: "status") bool? status,
    @JsonKey(name: "images") List<String>? images,
    @JsonKey(name: "colorAttributes") List<Color>? colorAttributes,
    @JsonKey(name: "sizeAttributes") List<dynamic>? sizeAttributes,
    @JsonKey(name: "variantType") String? variantType,
    @JsonKey(name: "colorVariants") List<ColorVariant>? colorVariants,
    @JsonKey(name: "ratings") int? ratings,
    @JsonKey(name: "totalRatings") int? totalRatings,
    @JsonKey(name: "ratedBy") int? ratedBy,
    @JsonKey(name: "metaRobots") String? metaRobots,
    @JsonKey(name: "isTodaysDeal") bool? isTodaysDeal,
    @JsonKey(name: "isFeatured") bool? isFeatured,
    @JsonKey(name: "isPublished") bool? isPublished,
    @JsonKey(name: "searchWords") String? searchWords,
    @JsonKey(name: "isDeleted") bool? isDeleted,
    @JsonKey(name: "sizeVariants") List<dynamic>? sizeVariants,
    @JsonKey(name: "createdAt") String? createdAt,
    @JsonKey(name: "updatedAt") String? updatedAt,
    @JsonKey(name: "__v") int? v,
    @JsonKey(name: "noneText") String? noneText,
    @JsonKey(name: "breadCrums") List<BreadCrum>? breadCrums,
  }) = _ProductDetailData;

  factory ProductDetailData.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailDataFromJson(json);
}

@freezed
class Brand with _$Brand {
  const factory Brand({
    @JsonKey(name: "_id") String? id,
    @JsonKey(name: "slug") String? slug,
    @JsonKey(name: "name") String? name,
  }) = _Brand;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}

@freezed
class BreadCrum with _$BreadCrum {
  const factory BreadCrum({
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "slug") String? slug,
  }) = _BreadCrum;

  factory BreadCrum.fromJson(Map<String, dynamic> json) =>
      _$BreadCrumFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    @JsonKey(name: "_id") String? id,
    @JsonKey(name: "slug") String? slug,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "level") int? level,
    @JsonKey(name: "parentId") String? parentId,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
class Color with _$Color {
  const factory Color({
    @JsonKey(name: "_id") String? id,
    @JsonKey(name: "isTwin") bool? isTwin,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "colorValue") List<String>? colorValue,
  }) = _Color;

  factory Color.fromJson(Map<String, dynamic> json) => _$ColorFromJson(json);
}

@freezed
class ColorVariant with _$ColorVariant {
  const factory ColorVariant({
    @JsonKey(name: "color") Color? color,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "rewardPoint") int? rewardPoint,
    @JsonKey(name: "strikePrice") int? strikePrice,
    @JsonKey(name: "offPercent") int? offPercent,
    @JsonKey(name: "minOrder") int? minOrder,
    @JsonKey(name: "maxOrder") int? maxOrder,
    @JsonKey(name: "status") bool? status,
    @JsonKey(name: "images") List<dynamic>? images,
    @JsonKey(name: "productCode") String? productCode,
    @JsonKey(name: "_id") String? id,
  }) = _ColorVariant;

  factory ColorVariant.fromJson(Map<String, dynamic> json) =>
      _$ColorVariantFromJson(json);
}
