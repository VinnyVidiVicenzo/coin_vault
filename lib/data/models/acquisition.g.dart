// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acquisition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Acquisition _$AcquisitionFromJson(Map<String, dynamic> json) => _Acquisition(
  id: json['id'] as String?,
  itemId: json['itemId'] as String,
  purchaseDate: json['purchaseDate'] == null
      ? null
      : DateTime.parse(json['purchaseDate'] as String),
  sourceType: json['sourceType'] as String?,
  sellerName: json['sellerName'] as String?,
  sellerContact: json['sellerContact'] as String?,
  lotNumber: json['lotNumber'] as String?,
  purchasePrice: (json['purchasePrice'] as num?)?.toDouble(),
  buyersPremium: (json['buyersPremium'] as num?)?.toDouble(),
  shippingCost: (json['shippingCost'] as num?)?.toDouble(),
  taxPaid: (json['taxPaid'] as num?)?.toDouble(),
  otherFees: (json['otherFees'] as num?)?.toDouble(),
  totalCost: (json['totalCost'] as num?)?.toDouble(),
  currency: json['currency'] as String? ?? 'USD',
  paymentMethod: json['paymentMethod'] as String?,
  costBasisType: json['costBasisType'] as String? ?? 'known',
  notes: json['notes'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AcquisitionToJson(_Acquisition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
      'sourceType': instance.sourceType,
      'sellerName': instance.sellerName,
      'sellerContact': instance.sellerContact,
      'lotNumber': instance.lotNumber,
      'purchasePrice': instance.purchasePrice,
      'buyersPremium': instance.buyersPremium,
      'shippingCost': instance.shippingCost,
      'taxPaid': instance.taxPaid,
      'otherFees': instance.otherFees,
      'totalCost': instance.totalCost,
      'currency': instance.currency,
      'paymentMethod': instance.paymentMethod,
      'costBasisType': instance.costBasisType,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
