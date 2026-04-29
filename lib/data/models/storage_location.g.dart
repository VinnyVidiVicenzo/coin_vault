// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StorageLocation _$StorageLocationFromJson(Map<String, dynamic> json) =>
    _StorageLocation(
      id: json['id'] as String?,
      locationName: json['locationName'] as String,
      locationType: json['locationType'] as String?,
      addressNotes: json['addressNotes'] as String?,
      environmentNotes: json['environmentNotes'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$StorageLocationToJson(_StorageLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'locationName': instance.locationName,
      'locationType': instance.locationType,
      'addressNotes': instance.addressNotes,
      'environmentNotes': instance.environmentNotes,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_ItemStorage _$ItemStorageFromJson(Map<String, dynamic> json) => _ItemStorage(
  id: json['id'] as String?,
  itemId: json['itemId'] as String,
  storageLocationId: json['storageLocationId'] as String,
  containerType: json['containerType'] as String?,
  containerLabel: json['containerLabel'] as String?,
  slotEnvelopeNumber: json['slotEnvelopeNumber'] as String?,
  holderType: json['holderType'] as String?,
  environmentNotes: json['environmentNotes'] as String?,
  lastVerifiedDate: json['lastVerifiedDate'] == null
      ? null
      : DateTime.parse(json['lastVerifiedDate'] as String),
  notes: json['notes'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  location: json['location'] == null
      ? null
      : StorageLocation.fromJson(json['location'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ItemStorageToJson(_ItemStorage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'storageLocationId': instance.storageLocationId,
      'containerType': instance.containerType,
      'containerLabel': instance.containerLabel,
      'slotEnvelopeNumber': instance.slotEnvelopeNumber,
      'holderType': instance.holderType,
      'environmentNotes': instance.environmentNotes,
      'lastVerifiedDate': instance.lastVerifiedDate?.toIso8601String(),
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'location': instance.location,
    };
