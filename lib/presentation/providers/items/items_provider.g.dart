// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemRepositoryHash() => r'7832653df2cf370e669e168c63638c87ec393c7d';

/// See also [itemRepository].
@ProviderFor(itemRepository)
final itemRepositoryProvider = AutoDisposeProvider<ItemRepository>.internal(
  itemRepository,
  name: r'itemRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$itemRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ItemRepositoryRef = AutoDisposeProviderRef<ItemRepository>;
String _$filteredItemsHash() => r'b52e7a0d5727ea841fd15e89fd3d0436ba802f81';

/// See also [filteredItems].
@ProviderFor(filteredItems)
final filteredItemsProvider = AutoDisposeFutureProvider<List<Item>>.internal(
  filteredItems,
  name: r'filteredItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredItemsRef = AutoDisposeFutureProviderRef<List<Item>>;
String _$itemsListHash() => r'fe3a98c39dfd92c4ba486a80624ad751c4879bea';

/// See also [ItemsList].
@ProviderFor(ItemsList)
final itemsListProvider =
    AutoDisposeAsyncNotifierProvider<ItemsList, List<Item>>.internal(
      ItemsList.new,
      name: r'itemsListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$itemsListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ItemsList = AutoDisposeAsyncNotifier<List<Item>>;
String _$itemDetailHash() => r'5ae597a1e181c4aafcd4b001fbe1ffe64d67a6f7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ItemDetail extends BuildlessAutoDisposeAsyncNotifier<Item?> {
  late final String id;

  FutureOr<Item?> build(String id);
}

/// See also [ItemDetail].
@ProviderFor(ItemDetail)
const itemDetailProvider = ItemDetailFamily();

/// See also [ItemDetail].
class ItemDetailFamily extends Family<AsyncValue<Item?>> {
  /// See also [ItemDetail].
  const ItemDetailFamily();

  /// See also [ItemDetail].
  ItemDetailProvider call(String id) {
    return ItemDetailProvider(id);
  }

  @override
  ItemDetailProvider getProviderOverride(
    covariant ItemDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'itemDetailProvider';
}

/// See also [ItemDetail].
class ItemDetailProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ItemDetail, Item?> {
  /// See also [ItemDetail].
  ItemDetailProvider(String id)
    : this._internal(
        () => ItemDetail()..id = id,
        from: itemDetailProvider,
        name: r'itemDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$itemDetailHash,
        dependencies: ItemDetailFamily._dependencies,
        allTransitiveDependencies: ItemDetailFamily._allTransitiveDependencies,
        id: id,
      );

  ItemDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<Item?> runNotifierBuild(covariant ItemDetail notifier) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(ItemDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: ItemDetailProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ItemDetail, Item?> createElement() {
    return _ItemDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ItemDetailRef on AutoDisposeAsyncNotifierProviderRef<Item?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ItemDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ItemDetail, Item?>
    with ItemDetailRef {
  _ItemDetailProviderElement(super.provider);

  @override
  String get id => (origin as ItemDetailProvider).id;
}

String _$itemFilterHash() => r'bb90a4050202aff64282e78c00364c24ed579322';

/// See also [ItemFilter].
@ProviderFor(ItemFilter)
final itemFilterProvider =
    AutoDisposeNotifierProvider<ItemFilter, ItemFilterState>.internal(
      ItemFilter.new,
      name: r'itemFilterProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$itemFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ItemFilter = AutoDisposeNotifier<ItemFilterState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
