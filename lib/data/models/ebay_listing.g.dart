// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ebay_listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EbayListing _$EbayListingFromJson(Map<String, dynamic> json) => _EbayListing(
  id: json['id'] as String?,
  itemId: json['itemId'] as String,
  listingUrl: json['listingUrl'] as String?,
  ebayItemNumber: json['ebayItemNumber'] as String?,
  listingStatus: json['listingStatus'] as String? ?? 'draft',
  listPrice: (json['listPrice'] as num?)?.toDouble(),
  bestOfferMin: (json['bestOfferMin'] as num?)?.toDouble(),
  soldPrice: (json['soldPrice'] as num?)?.toDouble(),
  soldDate: json['soldDate'] == null
      ? null
      : DateTime.parse(json['soldDate'] as String),
  buyerUsername: json['buyerUsername'] as String?,
  shippingCharged: (json['shippingCharged'] as num?)?.toDouble(),
  ebayFinalValueFee: (json['ebayFinalValueFee'] as num?)?.toDouble(),
  ebayAdFee: (json['ebayAdFee'] as num?)?.toDouble(),
  paypalFee: (json['paypalFee'] as num?)?.toDouble(),
  otherFees: (json['otherFees'] as num?)?.toDouble(),
  netProceeds: (json['netProceeds'] as num?)?.toDouble(),
  listedDate: json['listedDate'] == null
      ? null
      : DateTime.parse(json['listedDate'] as String),
  endedDate: json['endedDate'] == null
      ? null
      : DateTime.parse(json['endedDate'] as String),
  notes: json['notes'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$EbayListingToJson(_EbayListing instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'listingUrl': instance.listingUrl,
      'ebayItemNumber': instance.ebayItemNumber,
      'listingStatus': instance.listingStatus,
      'listPrice': instance.listPrice,
      'bestOfferMin': instance.bestOfferMin,
      'soldPrice': instance.soldPrice,
      'soldDate': instance.soldDate?.toIso8601String(),
      'buyerUsername': instance.buyerUsername,
      'shippingCharged': instance.shippingCharged,
      'ebayFinalValueFee': instance.ebayFinalValueFee,
      'ebayAdFee': instance.ebayAdFee,
      'paypalFee': instance.paypalFee,
      'otherFees': instance.otherFees,
      'netProceeds': instance.netProceeds,
      'listedDate': instance.listedDate?.toIso8601String(),
      'endedDate': instance.endedDate?.toIso8601String(),
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
