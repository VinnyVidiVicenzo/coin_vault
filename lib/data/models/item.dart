import 'package:freezed_annotation/freezed_annotation.dart';
import 'catalog_reference.dart';
import 'item_image.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
sealed class Item with _$Item {
  const factory Item({
    required String id,
    required String ownerId,

    // Identity
    @Default('coin') String itemType,
    String? country,
    String? issuingAuthority,
    String? denomination,
    double? denominationNumeric,
    int? yearStart,
    int? yearEnd,
    String? mintMark,
    String? series,
    String? variety,
    @Default(false) bool isPublic,

    // Physical — coins
    String? metal,
    double? weightGrams,
    double? diameterMm,
    String? edgeType,
    String? coinOrientation,

    // Physical — notes
    double? noteWidthMm,
    double? noteHeightMm,

    // Coin-specific
    String? obverseDescription,
    String? reverseDescription,
    String? edgeDescription,
    String? dieMarkers,

    // Note-specific
    String? serialNumber,
    String? serialBlock,
    String? signatureCombination,
    String? sealColor,
    String? district,
    String? plateNumberFront,
    String? plateNumberBack,
    @Default(false) bool isStarNote,

    // Condition
    String? grade,
    double? gradeNumeric,
    String? gradingCompany,
    String? certNumber,
    @Default(false) bool isSlabbed,
    @Default(false) bool detailsGrade,
    String? detailsNote,
    @Default([]) List<String> defects,

    // Certification
    String? designation,
    String? holderGeneration,
    int? populationObverse,
    int? populationReverse,
    String? certVerificationUrl,
    @Default('raw') String submissionStatus,

    // Quantity
    @Default('single') String quantityType,
    @Default(1) int quantity,
    @Default(0) int duplicateCount,

    // Notes
    String? historicalContext,
    String? attributionNotes,
    String? provenance,
    @Default([]) List<String> researchLinks,
    String? internalNotes,

    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,

    // Related data (loaded separately)
    @Default([]) List<CatalogReference> catalogReferences,
    @Default([]) List<ItemImage> images,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
