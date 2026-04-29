// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ebay_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ebayRepositoryHash() => r'fa73dab669bffe4449f6b7627bb3f4b4f07e9f39';

/// See also [ebayRepository].
@ProviderFor(ebayRepository)
final ebayRepositoryProvider = AutoDisposeProvider<EbayRepository>.internal(
  ebayRepository,
  name: r'ebayRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ebayRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EbayRepositoryRef = AutoDisposeProviderRef<EbayRepository>;
String _$ebayListingsHash() => r'c8ee0135f568607e056d9bc7efdf448de4c30e3d';

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

abstract class _$EbayListings
    extends BuildlessAutoDisposeAsyncNotifier<List<EbayListing>> {
  late final String itemId;

  FutureOr<List<EbayListing>> build(String itemId);
}

/// See also [EbayListings].
@ProviderFor(EbayListings)
const ebayListingsProvider = EbayListingsFamily();

/// See also [EbayListings].
class EbayListingsFamily extends Family<AsyncValue<List<EbayListing>>> {
  /// See also [EbayListings].
  const EbayListingsFamily();

  /// See also [EbayListings].
  EbayListingsProvider call(String itemId) {
    return EbayListingsProvider(itemId);
  }

  @override
  EbayListingsProvider getProviderOverride(
    covariant EbayListingsProvider provider,
  ) {
    return call(provider.itemId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ebayListingsProvider';
}

/// See also [EbayListings].
class EbayListingsProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<EbayListings, List<EbayListing>> {
  /// See also [EbayListings].
  EbayListingsProvider(String itemId)
    : this._internal(
        () => EbayListings()..itemId = itemId,
        from: ebayListingsProvider,
        name: r'ebayListingsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$ebayListingsHash,
        dependencies: EbayListingsFamily._dependencies,
        allTransitiveDependencies:
            EbayListingsFamily._allTransitiveDependencies,
        itemId: itemId,
      );

  EbayListingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final String itemId;

  @override
  FutureOr<List<EbayListing>> runNotifierBuild(
    covariant EbayListings notifier,
  ) {
    return notifier.build(itemId);
  }

  @override
  Override overrideWith(EbayListings Function() create) {
    return ProviderOverride(
      origin: this,
      override: EbayListingsProvider._internal(
        () => create()..itemId = itemId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EbayListings, List<EbayListing>>
  createElement() {
    return _EbayListingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EbayListingsProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EbayListingsRef
    on AutoDisposeAsyncNotifierProviderRef<List<EbayListing>> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _EbayListingsProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<EbayListings, List<EbayListing>>
    with EbayListingsRef {
  _EbayListingsProviderElement(super.provider);

  @override
  String get itemId => (origin as EbayListingsProvider).itemId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
