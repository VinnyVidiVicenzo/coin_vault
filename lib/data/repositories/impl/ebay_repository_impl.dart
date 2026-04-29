import '../../models/ebay_listing.dart';
import '../../remote/supabase/supabase_client.dart';
import '../../../core/constants/db_constants.dart';

class EbayRepository {
  Future<List<EbayListing>> fetchForItem(String itemId) async {
    final data = await supabase
        .from(DbConstants.ebayListings)
        .select()
        .eq('item_id', itemId)
        .order('created_at', ascending: false) as List;
    return data
        .map((r) => EbayListing.fromJson(Map<String, dynamic>.from(r)))
        .toList();
  }

  Future<List<EbayListing>> fetchActive() async {
    final data = await supabase
        .from(DbConstants.ebayListings)
        .select()
        .eq('listing_status', 'active')
        .order('listed_date', ascending: false) as List;
    return data
        .map((r) => EbayListing.fromJson(Map<String, dynamic>.from(r)))
        .toList();
  }

  Future<EbayListing> upsert(EbayListing listing) async {
    final payload = <String, dynamic>{
      'item_id': listing.itemId,
      'owner_id': supabase.auth.currentUser!.id,
      'listing_url': listing.listingUrl,
      'ebay_item_number': listing.ebayItemNumber,
      'listing_status': listing.listingStatus,
      'list_price': listing.listPrice,
      'best_offer_min': listing.bestOfferMin,
      'sold_price': listing.soldPrice,
      'sold_date': listing.soldDate?.toIso8601String().substring(0, 10),
      'buyer_username': listing.buyerUsername,
      'shipping_charged': listing.shippingCharged,
      'ebay_final_value_fee': listing.ebayFinalValueFee,
      'ebay_ad_fee': listing.ebayAdFee,
      'paypal_fee': listing.paypalFee,
      'other_fees': listing.otherFees,
      'listed_date': listing.listedDate?.toIso8601String().substring(0, 10),
      'ended_date': listing.endedDate?.toIso8601String().substring(0, 10),
      'notes': listing.notes,
    };

    if (listing.id != null) {
      payload['id'] = listing.id;
      final data = await supabase
          .from(DbConstants.ebayListings)
          .upsert(payload)
          .select()
          .single();
      return EbayListing.fromJson(Map<String, dynamic>.from(data));
    } else {
      final data = await supabase
          .from(DbConstants.ebayListings)
          .insert(payload)
          .select()
          .single();
      return EbayListing.fromJson(Map<String, dynamic>.from(data));
    }
  }

  Future<void> delete(String listingId) async {
    await supabase
        .from(DbConstants.ebayListings)
        .delete()
        .eq('id', listingId);
  }
}
