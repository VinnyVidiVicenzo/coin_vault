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

  void setCategoryId(String? id) => state = state.copyWith(categoryId: id, subcategory: null);
  void setSubcategory(String? sub) => state = state.copyWith(subcategory: sub);
  void setType(String? type) => state = state.copyWith(itemType: type);
  void setCountry(String? country) => state = state.copyWith(country: country);
  void setGradingCompany(String? gc) => state = state.copyWith(gradingCompany: gc);
  void setSlabbed(bool? slabbed) => state = state.copyWith(isSlabbed: slabbed);
  void setSearch(String? query) => state = state.copyWith(searchQuery: query);
  void setMinGrade(double? g) => state = state.copyWith(minGrade: g);
  void setMaxGrade(double? g) => state = state.copyWith(maxGrade: g);
  void setMintMark(String? m) => state = state.copyWith(mintMark: m);
  void setMinYear(int? y) => state = state.copyWith(minYear: y);
  void setMaxYear(int? y) => state = state.copyWith(maxYear: y);
  void setSort(String sort) => state = state.copyWith(sortBy: sort);
  void reset() => state = const ItemFilterState();
}

class ItemFilterState {
  final String? categoryId;    // 'us_coins' | 'world_coins' | 'paper_money' | 'exonumia'
  final String? subcategory;   // e.g. 'Morgan Dollars'
  final String? itemType;
  final String? country;
  final String? gradingCompany;
  final bool? isSlabbed;
  final String? searchQuery;
  final double? minGrade;
  final double? maxGrade;
  final String? mintMark;
  final int? minYear;
  final int? maxYear;
  final String sortBy;

  const ItemFilterState({
    this.categoryId,
    this.subcategory,
    this.itemType,
    this.country,
    this.gradingCompany,
    this.isSlabbed,
    this.searchQuery,
    this.minGrade,
    this.maxGrade,
    this.mintMark,
    this.minYear,
    this.maxYear,
    this.sortBy = 'date_added',
  });

  ItemFilterState copyWith({
    Object? categoryId = const _S(),
    Object? subcategory = const _S(),
    Object? itemType = const _S(),
    Object? country = const _S(),
    Object? gradingCompany = const _S(),
    Object? isSlabbed = const _S(),
    Object? searchQuery = const _S(),
    Object? minGrade = const _S(),
    Object? maxGrade = const _S(),
    Object? mintMark = const _S(),
    Object? minYear = const _S(),
    Object? maxYear = const _S(),
    String? sortBy,
  }) =>
      ItemFilterState(
        categoryId: categoryId is _S ? this.categoryId : categoryId as String?,
        subcategory: subcategory is _S ? this.subcategory : subcategory as String?,
        itemType: itemType is _S ? this.itemType : itemType as String?,
        country: country is _S ? this.country : country as String?,
        gradingCompany: gradingCompany is _S ? this.gradingCompany : gradingCompany as String?,
        isSlabbed: isSlabbed is _S ? this.isSlabbed : isSlabbed as bool?,
        searchQuery: searchQuery is _S ? this.searchQuery : searchQuery as String?,
        minGrade: minGrade is _S ? this.minGrade : minGrade as double?,
        maxGrade: maxGrade is _S ? this.maxGrade : maxGrade as double?,
        mintMark: mintMark is _S ? this.mintMark : mintMark as String?,
        minYear: minYear is _S ? this.minYear : minYear as int?,
        maxYear: maxYear is _S ? this.maxYear : maxYear as int?,
        sortBy: sortBy ?? this.sortBy,
      );

  bool get hasFilters =>
      categoryId != null || subcategory != null || itemType != null ||
      country != null || gradingCompany != null || isSlabbed != null ||
      minGrade != null || maxGrade != null || mintMark != null ||
      minYear != null || maxYear != null ||
      (searchQuery != null && searchQuery!.isNotEmpty);

  int get activeFilterCount => [
    categoryId, subcategory, itemType, country, gradingCompany,
    isSlabbed, minGrade, maxGrade, mintMark, minYear, maxYear,
  ].where((e) => e != null).length +
      (searchQuery != null && searchQuery!.isNotEmpty ? 1 : 0);
}

class _S { const _S(); }

@riverpod
Future<List<Item>> filteredItems(FilteredItemsRef ref) async {
  final filter = ref.watch(itemFilterProvider);
  final repo = ref.read(itemRepositoryProvider);

  if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
    return repo.searchItems(filter.searchQuery!);
  }

  // Derive item_type and country from category
  String? itemType = filter.itemType;
  String? country = filter.country;

  if (filter.categoryId == 'us_coins') {
    itemType = 'coin';
    country = 'United States';
  } else if (filter.categoryId == 'world_coins') {
    itemType = 'coin';
    // country stays null (all countries) unless set explicitly
  } else if (filter.categoryId == 'paper_money') {
    itemType = 'note';
  } else if (filter.categoryId == 'exonumia') {
    // tokens, medals
  }

  return repo.fetchItems(
    itemType: itemType,
    country: country,
    gradingCompany: filter.gradingCompany,
    isSlabbed: filter.isSlabbed,
    series: filter.subcategory,
    minGrade: filter.minGrade,
    maxGrade: filter.maxGrade,
    mintMark: filter.mintMark,
    minYear: filter.minYear,
    maxYear: filter.maxYear,
    sortBy: filter.sortBy,
  );
}
