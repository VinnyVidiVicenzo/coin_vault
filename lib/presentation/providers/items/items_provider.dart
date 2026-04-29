import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/item.dart';
import '../../../data/repositories/impl/item_repository_impl.dart';

part 'items_provider.g.dart';

@riverpod
ItemRepository itemRepository(ItemRepositoryRef ref) => ItemRepository();

@riverpod
class ItemsList extends _$ItemsList {
  @override
  Future<List<Item>> build() => ref.read(itemRepositoryProvider).fetchItems();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(itemRepositoryProvider).fetchItems(),
    );
  }

  Future<void> deleteItem(String id) async {
    await ref.read(itemRepositoryProvider).deleteItem(id);
    refresh();
  }

  Future<void> togglePublic(String id, bool isPublic) async {
    await ref.read(itemRepositoryProvider).setPublic(id, isPublic);
    refresh();
  }
}

@riverpod
class ItemDetail extends _$ItemDetail {
  @override
  Future<Item?> build(String id) =>
      ref.read(itemRepositoryProvider).fetchItem(id);

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(itemRepositoryProvider).fetchItem(id),
    );
  }
}

@riverpod
class ItemFilter extends _$ItemFilter {
  @override
  ItemFilterState build() => const ItemFilterState();

  void setType(String? type) => state = state.copyWith(itemType: type);
  void setCountry(String? country) => state = state.copyWith(country: country);
  void setGradingCompany(String? gc) => state = state.copyWith(gradingCompany: gc);
  void setSlabbed(bool? slabbed) => state = state.copyWith(isSlabbed: slabbed);
  void setSearch(String? query) => state = state.copyWith(searchQuery: query);
  void reset() => state = const ItemFilterState();
}

class ItemFilterState {
  final String? itemType;
  final String? country;
  final String? gradingCompany;
  final bool? isSlabbed;
  final String? searchQuery;

  const ItemFilterState({
    this.itemType,
    this.country,
    this.gradingCompany,
    this.isSlabbed,
    this.searchQuery,
  });

  ItemFilterState copyWith({
    Object? itemType = const _UnsetSentinel(),
    Object? country = const _UnsetSentinel(),
    Object? gradingCompany = const _UnsetSentinel(),
    Object? isSlabbed = const _UnsetSentinel(),
    Object? searchQuery = const _UnsetSentinel(),
  }) =>
      ItemFilterState(
        itemType: itemType is _UnsetSentinel ? this.itemType : itemType as String?,
        country: country is _UnsetSentinel ? this.country : country as String?,
        gradingCompany: gradingCompany is _UnsetSentinel ? this.gradingCompany : gradingCompany as String?,
        isSlabbed: isSlabbed is _UnsetSentinel ? this.isSlabbed : isSlabbed as bool?,
        searchQuery: searchQuery is _UnsetSentinel ? this.searchQuery : searchQuery as String?,
      );

  bool get hasFilters =>
      itemType != null || country != null || gradingCompany != null ||
      isSlabbed != null || (searchQuery != null && searchQuery!.isNotEmpty);
}

class _UnsetSentinel {
  const _UnsetSentinel();
}

@riverpod
Future<List<Item>> filteredItems(FilteredItemsRef ref) async {
  final filter = ref.watch(itemFilterProvider);
  final repo = ref.read(itemRepositoryProvider);

  if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
    return repo.searchItems(filter.searchQuery!);
  }

  return repo.fetchItems(
    itemType: filter.itemType,
    country: filter.country,
    gradingCompany: filter.gradingCompany,
    isSlabbed: filter.isSlabbed,
  );
}
