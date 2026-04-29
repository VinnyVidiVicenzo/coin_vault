import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_location.freezed.dart';
part 'storage_location.g.dart';

@freezed
sealed class StorageLocation with _$StorageLocation {
  const factory StorageLocation({
    String? id,
    required String locationName,
    String? locationType,
    String? addressNotes,
    String? environmentNotes,
    @Default(true) bool isActive,
    DateTime? createdAt,
  }) = _StorageLocation;

  factory StorageLocation.fromJson(Map<String, dynamic> json) =>
      _$StorageLocationFromJson(json);
}

@freezed
sealed class ItemStorage with _$ItemStorage {
  const factory ItemStorage({
    String? id,
    required String itemId,
    required String storageLocationId,
    String? containerType,
    String? containerLabel,
    String? slotEnvelopeNumber,
    String? holderType,
    String? environmentNotes,
    DateTime? lastVerifiedDate,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    StorageLocation? location,
  }) = _ItemStorage;

  factory ItemStorage.fromJson(Map<String, dynamic> json) =>
      _$ItemStorageFromJson(json);
}
