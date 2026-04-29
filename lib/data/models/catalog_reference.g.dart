// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogReference _$CatalogReferenceFromJson(Map<String, dynamic> json) =>
    _CatalogReference(
      id: json['id'] as String?,
      itemId: json['itemId'] as String,
      catalogSystem: json['catalogSystem'] as String,
      referenceNumber: json['referenceNumber'] as String,
      varietyName: json['varietyName'] as String?,
      diePair: json['diePair'] as String?,
      attributionConfidence: json['attributionConfidence'] as String?,
      attributionSource: json['attributionSource'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CatalogReferenceToJson(_CatalogReference instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'catalogSystem': instance.catalogSystem,
      'referenceNumber': instance.referenceNumber,
      'varietyName': instance.varietyName,
      'diePair': instance.diePair,
      'attributionConfidence': instance.attributionConfidence,
      'attributionSource': instance.attributionSource,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
