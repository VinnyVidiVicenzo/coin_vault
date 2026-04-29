import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/ebay_listing.dart';
import '../../../data/repositories/impl/ebay_repository_impl.dart';

part 'ebay_provider.g.dart';

@riverpod
EbayRepository ebayRepository(EbayRepositoryRef ref) => EbayRepository();

@riverpod
class EbayListings extends _$EbayListings {
  @override
  Future<List<EbayListing>> build(String itemId) =>
      ref.read(ebayRepositoryProvider).fetchForItem(itemId);

  Future<void> add(EbayListing listing) async {
    await ref.read(ebayRepositoryProvider).upsert(listing);
    ref.invalidateSelf();
  }

  Future<void> updateListing(EbayListing listing) async {
    await ref.read(ebayRepositoryProvider).upsert(listing);
    ref.invalidateSelf();
  }

  Future<void> delete(String listingId) async {
    await ref.read(ebayRepositoryProvider).delete(listingId);
    ref.invalidateSelf();
  }
}
