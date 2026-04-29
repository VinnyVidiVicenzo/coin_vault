import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_reference.freezed.dart';
part 'catalog_reference.g.dart';

@freezed
sealed class CatalogReference with _$CatalogReference {
  const factory CatalogReference({
    String? id,
    required String itemId,
    required String catalogSystem,
    required String referenceNumber,
    String? varietyName,
    String? diePair,
    String? attributionConfidence,
    String? attributionSource,
    String? notes,
    DateTime? createdAt,
  }) = _CatalogReference;

  factory CatalogReference.fromJson(Map<String, dynamic> json) =>
      _$CatalogReferenceFromJson(json);
}
