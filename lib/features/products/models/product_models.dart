import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_models.freezed.dart';
part 'product_models.g.dart';

@freezed
class ProductDetailResponse with _$ProductDetailResponse {
  const factory ProductDetailResponse({
    String? title,
    String? message,
    ProductData? data,
  }) = _ProductDetailResponse;

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailResponseFromJson(json);
}

@freezed
class ProductData with _$ProductData {
  const factory ProductData({
    String? id,
    String? slug,
    Category? category,
    Brand? brand,
    String? title,
    String? ingredient,
    String? howToUse,
    String? description,
    int? price,
    int? rewardPoint,
    int? commissionPercentage,
    int? strikePrice,
    int? offPercent,
    int? minOrder,
    int? maxOrder,
    bool? status,
    List<String>? images,
    List<Color>? colorAttributes,
    List<dynamic>? sizeAttributes,
    String? variantType,
    List<ColorVariant>? colorVariants,
    int? ratings,
    int? totalRatings,
    int? ratedBy,
    FilterOptions? filterOptions,
    String? metaRobots,
    bool? isTodaysDeal,
    bool? isFeatured,
    bool? isPublished,
    String? searchWords,
    bool? isDeleted,
    List<dynamic>? sizeVariants,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? noneText,
    List<BreadCrum>? breadCrums,
    bool? wished,
  }) = _ProductData;

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);
}

@freezed
class Brand with _$Brand {
  const factory Brand({
    String? id,
    String? slug,
    String? name,
  }) = _Brand;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}

@freezed
class BreadCrum with _$BreadCrum {
  const factory BreadCrum({
    String? title,
    String? slug,
  }) = _BreadCrum;

  factory BreadCrum.fromJson(Map<String, dynamic> json) =>
      _$BreadCrumFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    String? id,
    String? slug,
    String? title,
    int? level,
    String? parentId,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
class Color with _$Color {
  const factory Color({
    String? id,
    bool? isTwin,
    String? name,
    List<String>? colorValue,
  }) = _Color;

  factory Color.fromJson(Map<String, dynamic> json) => _$ColorFromJson(json);
}

@freezed
class ColorVariant with _$ColorVariant {
  const factory ColorVariant({
    Color? color,
    int? price,
    int? rewardPoint,
    int? strikePrice,
    int? offPercent,
    int? minOrder,
    int? maxOrder,
    bool? status,
    List<dynamic>? images,
    String? productCode,
    String? id,
  }) = _ColorVariant;

  factory ColorVariant.fromJson(Map<String, dynamic> json) =>
      _$ColorVariantFromJson(json);
}

@freezed
class FilterOptions with _$FilterOptions {
  const factory FilterOptions({
    bool? age12,
    bool? age20,
    bool? age30,
    bool? age40,
    bool? age50,
    bool? benefitsAntiAgeing,
    bool? benefitsAntiShine,
    bool? benefitsBrightning,
    bool? benefitsBronzing,
    bool? benefitsCooling,
    bool? benefitsConcealing,
    bool? benefitsConditioning,
    bool? benefitsCurling,
    bool? benefitsDefining,
    bool? benefitsEnergising,
    bool? benefitsEvenSkinTone,
    bool? benefitsExfoliating,
    bool? benefitsFilling,
    bool? benefitsGrowthBoosting,
    bool? benefitsHydrating,
    bool? benefitsLengthening,
    bool? benefitsLongLasting,
    bool? benefitsMattifing,
    bool? benefitsMoisturing,
    bool? benefitsNourishing,
    bool? benefitsProtecting,
    bool? benefitsQuickDry,
    bool? benefitsRevitalising,
    bool? benefitsSculpting,
    bool? benefitsSmoothing,
    bool? benefitsThickening,
    bool? benefitsTransferProof,
    bool? benefitsVolumising,
    bool? benefitsWaterproof,
    bool? colorRed,
    String? colorRedHex,
    bool? colorBlue,
    String? colorBlueHex,
    bool? colorPink,
    String? colorPinkHex,
    bool? colorBlack,
    String? colorBlackHex,
    bool? colorBrown,
    String? colorBrownHex,
    bool? colorGrey,
    String? colorGreyHex,
    bool? colorGreen,
    String? colorGreenHex,
    bool? colorBurgundy,
    String? colorBurgundyHex,
    bool? colorPurple,
    String? colorPurpleHex,
    bool? coverageHigh,
    bool? coverageLight,
    bool? coverageMedium,
    bool? finishCreamy,
    bool? finishGlossy,
    bool? finishLuminious,
    bool? finishMalte,
    bool? finishMetaallic,
    bool? finishNatural,
    bool? finishSatin,
    bool? finishSheer,
    bool? finishShimmer,
    bool? finishShine,
    bool? formulationGel,
    bool? formulationLiquid,
    bool? formulationPencil,
    bool? formulationPowder,
    bool? formulationStick,
    bool? formulationWax,
    bool? formulationCream,
    bool? formulationLipBalm,
    bool? formulationLoose,
    bool? formulationPearls,
    bool? formulationPressed,
    bool? formulationSerum,
    bool? skinTypeCombination,
    bool? skinTypeDry,
    bool? skinTypeNormal,
    bool? skinTypeOily,
    bool? skinTypeSensitive,
  }) = _FilterOptions;

  factory FilterOptions.fromJson(Map<String, dynamic> json) =>
      _$FilterOptionsFromJson(json);
}
