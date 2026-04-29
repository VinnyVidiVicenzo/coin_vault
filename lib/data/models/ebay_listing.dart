import 'package:freezed_annotation/freezed_annotation.dart';

part 'ebay_listing.freezed.dart';
part 'ebay_listing.g.dart';

@freezed
sealed class EbayListing with _$EbayListing {
  const factory EbayListing({
    String? id,
    required String itemId,
    String? listingUrl,
    String? ebayItemNumber,
    @Default('draft') String listingStatus,
    double? listPrice,
    double? bestOfferMin,
    double? soldPrice,
    DateTime? soldDate,
    String? buyerUsername,
    double? shippingCharged,
    double? ebayFinalValueFee,
    double? ebayAdFee,
    double? paypalFee,
    double? otherFees,
    double? netProceeds,
    DateTime? listedDate,
    DateTime? endedDate,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _EbayListing;

  factory EbayListing.fromJson(Map<String, dynamic> json) =>
      _$EbayListingFromJson(json);
}
