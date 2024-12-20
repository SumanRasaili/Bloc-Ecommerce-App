// To parse this JSON data, do
//
//     final allProductsModel = allProductsModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_products_model.freezed.dart';
part 'all_products_model.g.dart';

@freezed
class AllProductsModel with _$AllProductsModel {
  const factory AllProductsModel({
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "message") String? message,
    @JsonKey(name: "data") AllProductData? data,
  }) = _AllProductsModel;

  factory AllProductsModel.fromJson(Map<String, dynamic> json) =>
      _$AllProductsModelFromJson(json);
}

@freezed
class AllProductData with _$AllProductData {
  const factory AllProductData({
    @JsonKey(name: "pagination") Pagination? pagination,
    @JsonKey(name: "docs") @Default([]) List<Doc> docs,
  }) = _AllProductData;

  factory AllProductData.fromJson(Map<String, dynamic> json) =>
      _$AllProductDataFromJson(json);
}

@freezed
class Doc with _$Doc {
  const factory Doc({
    @JsonKey(name: "_id") String? id,
    @JsonKey(name: "slug") String? slug,
    @JsonKey(name: "category") Category? category,
    @JsonKey(name: "brand") Brand? brand,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "ingredient") String? ingredient,
    @JsonKey(name: "howToUse") String? howToUse,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "rewardPoint") int? rewardPoint,
    @JsonKey(name: "commissionPercentage") int? commissionPercentage,
    @JsonKey(name: "strikePrice") int? strikePrice,
    @JsonKey(name: "offPercent") int? offPercent,
    @JsonKey(name: "minOrder") int? minOrder,
    @JsonKey(name: "maxOrder") int? maxOrder,
    @JsonKey(name: "status") bool? status,
    @JsonKey(name: "images") List<String?>? images,
    @JsonKey(name: "colorAttributes") List<String>? colorAttributes,
    @JsonKey(name: "sizeAttributes") List<String>? sizeAttributes,
    @JsonKey(name: "variantType") String? variantType,
    @JsonKey(name: "colorVariants") List<ColorVariant>? colorVariants,
    @JsonKey(name: "ratings") int? ratings,
    @JsonKey(name: "totalRatings") int? totalRatings,
    @JsonKey(name: "ratedBy") int? ratedBy,
    @JsonKey(name: "filterOptions") FilterOptions? filterOptions,
    @JsonKey(name: "metaRobots") String? metaRobots,
    @JsonKey(name: "isTodaysDeal") bool? isTodaysDeal,
    @JsonKey(name: "isFeatured") bool? isFeatured,
    @JsonKey(name: "isPublished") bool? isPublished,
    @JsonKey(name: "searchWords") String? searchWords,
    @JsonKey(name: "isDeleted") bool? isDeleted,
    @JsonKey(name: "sizeVariants") List<SizeVariant>? sizeVariants,
    @JsonKey(name: "createdAt") String? createdAt,
    @JsonKey(name: "updatedAt") String? updatedAt,
    @JsonKey(name: "noneText") String? noneText,
    @JsonKey(name: "colors") List<dynamic>? colors,
    @JsonKey(name: "sizes") List<dynamic>? sizes,
  }) = _Doc;

  factory Doc.fromJson(Map<String, dynamic> json) => _$DocFromJson(json);
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
class Category with _$Category {
  const factory Category({
    @JsonKey(name: "_id") String? id,
    @JsonKey(name: "title") String? title,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
class ColorVariant with _$ColorVariant {
  const factory ColorVariant({
    @JsonKey(name: "color") String? color,
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

@freezed
class FilterOptions with _$FilterOptions {
  const factory FilterOptions({
    @JsonKey(name: "age_12") bool? age12,
    @JsonKey(name: "age_20") bool? age20,
    @JsonKey(name: "age_30") bool? age30,
    @JsonKey(name: "age_40") bool? age40,
    @JsonKey(name: "age_50") bool? age50,
    @JsonKey(name: "benefits_anti_ageing") bool? benefitsAntiAgeing,
    @JsonKey(name: "benefits_anti_shine") bool? benefitsAntiShine,
    @JsonKey(name: "benefits_brightning") bool? benefitsBrightning,
    @JsonKey(name: "benefits_bronzing") bool? benefitsBronzing,
    @JsonKey(name: "benefits_cooling") bool? benefitsCooling,
    @JsonKey(name: "benefits_concealing") bool? benefitsConcealing,
    @JsonKey(name: "benefits_conditioning") bool? benefitsConditioning,
    @JsonKey(name: "benefits_curling") bool? benefitsCurling,
    @JsonKey(name: "benefits_defining") bool? benefitsDefining,
    @JsonKey(name: "benefits_energising") bool? benefitsEnergising,
    @JsonKey(name: "benefits_even_skin_tone") bool? benefitsEvenSkinTone,
    @JsonKey(name: "benefits_exfoliating") bool? benefitsExfoliating,
    @JsonKey(name: "benefits_filling") bool? benefitsFilling,
    @JsonKey(name: "benefits_growth_boosting") bool? benefitsGrowthBoosting,
    @JsonKey(name: "benefits_hydrating") bool? benefitsHydrating,
    @JsonKey(name: "benefits_lengthening") bool? benefitsLengthening,
    @JsonKey(name: "benefits_long_lasting") bool? benefitsLongLasting,
    @JsonKey(name: "benefits_mattifing") bool? benefitsMattifing,
    @JsonKey(name: "benefits_moisturing") bool? benefitsMoisturing,
    @JsonKey(name: "benefits_nourishing") bool? benefitsNourishing,
    @JsonKey(name: "benefits_protecting") bool? benefitsProtecting,
    @JsonKey(name: "benefits_quick_dry") bool? benefitsQuickDry,
    @JsonKey(name: "benefits_revitalising") bool? benefitsRevitalising,
    @JsonKey(name: "benefits_sculpting") bool? benefitsSculpting,
    @JsonKey(name: "benefits_smoothing") bool? benefitsSmoothing,
    @JsonKey(name: "benefits_thickening") bool? benefitsThickening,
    @JsonKey(name: "benefits_transfer_proof") bool? benefitsTransferProof,
    @JsonKey(name: "benefits_volumising") bool? benefitsVolumising,
    @JsonKey(name: "benefits_waterproof") bool? benefitsWaterproof,
    @JsonKey(name: "color_red") bool? colorRed,
    @JsonKey(name: "color_red_hex") String? colorRedHex,
    @JsonKey(name: "color_blue") bool? colorBlue,
    @JsonKey(name: "color_blue_hex") String? colorBlueHex,
    @JsonKey(name: "color_pink") bool? colorPink,
    @JsonKey(name: "color_pink_hex") String? colorPinkHex,
    @JsonKey(name: "color_black") bool? colorBlack,
    @JsonKey(name: "color_black_hex") String? colorBlackHex,
    @JsonKey(name: "color_brown") bool? colorBrown,
    @JsonKey(name: "color_brown_hex") String? colorBrownHex,
    @JsonKey(name: "color_grey") bool? colorGrey,
    @JsonKey(name: "color_grey_hex") String? colorGreyHex,
    @JsonKey(name: "color_green") bool? colorGreen,
    @JsonKey(name: "color_green_hex") String? colorGreenHex,
    @JsonKey(name: "color_burgundy") bool? colorBurgundy,
    @JsonKey(name: "color_burgundy_hex") String? colorBurgundyHex,
    @JsonKey(name: "color_purple") bool? colorPurple,
    @JsonKey(name: "color_purple_hex") String? colorPurpleHex,
    @JsonKey(name: "coverage_high") bool? coverageHigh,
    @JsonKey(name: "coverage_light") bool? coverageLight,
    @JsonKey(name: "coverage_medium") bool? coverageMedium,
    @JsonKey(name: "finish_creamy") bool? finishCreamy,
    @JsonKey(name: "finish_glossy") bool? finishGlossy,
    @JsonKey(name: "finish_luminious") bool? finishLuminious,
    @JsonKey(name: "finish_malte") bool? finishMalte,
    @JsonKey(name: "finish_metaallic") bool? finishMetaallic,
    @JsonKey(name: "finish_natural") bool? finishNatural,
    @JsonKey(name: "finish_satin") bool? finishSatin,
    @JsonKey(name: "finish_sheer") bool? finishSheer,
    @JsonKey(name: "finish_shimmer") bool? finishShimmer,
    @JsonKey(name: "finish_shine") bool? finishShine,
    @JsonKey(name: "formulation_gel") bool? formulationGel,
    @JsonKey(name: "formulation_liquid") bool? formulationLiquid,
    @JsonKey(name: "formulation_pencil") bool? formulationPencil,
    @JsonKey(name: "formulation_powder") bool? formulationPowder,
    @JsonKey(name: "formulation_stick") bool? formulationStick,
    @JsonKey(name: "formulation_wax") bool? formulationWax,
    @JsonKey(name: "formulation_cream") bool? formulationCream,
    @JsonKey(name: "formulation_lip_balm") bool? formulationLipBalm,
    @JsonKey(name: "formulation_loose") bool? formulationLoose,
    @JsonKey(name: "formulation_pearls") bool? formulationPearls,
    @JsonKey(name: "formulation_pressed") bool? formulationPressed,
    @JsonKey(name: "formulation_serum") bool? formulationSerum,
    @JsonKey(name: "skin_type_combination") bool? skinTypeCombination,
    @JsonKey(name: "skin_type_dry") bool? skinTypeDry,
    @JsonKey(name: "skin_type_normal") bool? skinTypeNormal,
    @JsonKey(name: "skin_type_oily") bool? skinTypeOily,
    @JsonKey(name: "skin_type_sensitive") bool? skinTypeSensitive,
  }) = _FilterOptions;

  factory FilterOptions.fromJson(Map<String, dynamic> json) =>
      _$FilterOptionsFromJson(json);
}

@freezed
class SizeVariant with _$SizeVariant {
  const factory SizeVariant({
    @JsonKey(name: "variantName") String? variantName,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "rewardPoint") int? rewardPoint,
    @JsonKey(name: "strikePrice") int? strikePrice,
    @JsonKey(name: "offPercent") int? offPercent,
    @JsonKey(name: "minOrder") int? minOrder,
    @JsonKey(name: "maxOrder") int? maxOrder,
    @JsonKey(name: "status") bool? status,
    @JsonKey(name: "images") List<String>? images,
    @JsonKey(name: "productCode") String? productCode,
    @JsonKey(name: "_id") String? id,
  }) = _SizeVariant;

  factory SizeVariant.fromJson(Map<String, dynamic> json) =>
      _$SizeVariantFromJson(json);
}

@freezed
class Pagination with _$Pagination {
  const factory Pagination({
    @JsonKey(name: "total") int? total,
    @JsonKey(name: "page") int? page,
    @JsonKey(name: "limit") int? limit,
    @JsonKey(name: "perviousPage") bool? perviousPage,
    @JsonKey(name: "nextPage") bool? nextPage,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}
