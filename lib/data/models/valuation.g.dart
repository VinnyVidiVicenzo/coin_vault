// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'valuation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Valuation _$ValuationFromJson(Map<String, dynamic> json) => _Valuation(
  id: json['id'] as String?,
  itemId: json['itemId'] as String,
  valuationDate: DateTime.parse(json['valuationDate'] as String),
  estimatedValue: (json['estimatedValue'] as num).toDouble(),
  currency: json['currency'] as String? ?? 'USD',
  valueType: json['valueType'] as String,
  valueSource: json['valueSource'] as String,
  confidence: json['confidence'] as String?,
  notes: json['notes'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ValuationToJson(_Valuation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'valuationDate': instance.valuationDate.toIso8601String(),
      'estimatedValue': instance.estimatedValue,
      'currency': instance.currency,
      'valueType': instance.valueType,
      'valueSource': instance.valueSource,
      'confidence': instance.confidence,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
