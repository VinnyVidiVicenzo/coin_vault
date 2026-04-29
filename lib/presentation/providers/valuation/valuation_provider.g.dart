// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'valuation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$valuationRepositoryHash() =>
    r'638d928b03823ae9f3fda76ec677ccf24fde4523';

/// See also [valuationRepository].
@ProviderFor(valuationRepository)
final valuationRepositoryProvider =
    AutoDisposeProvider<ValuationRepository>.internal(
      valuationRepository,
      name: r'valuationRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$valuationRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ValuationRepositoryRef = AutoDisposeProviderRef<ValuationRepository>;
String _$valuationHistoryHash() => r'fcbedbe12f48b23e61e8134e570468a69a4e033c';

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

/// See also [valuationHistory].
@ProviderFor(valuationHistory)
const valuationHistoryProvider = ValuationHistoryFamily();

/// See also [valuationHistory].
class ValuationHistoryFamily extends Family<AsyncValue<List<Valuation>>> {
  /// See also [valuationHistory].
  const ValuationHistoryFamily();

  /// See also [valuationHistory].
  ValuationHistoryProvider call(String itemId) {
    return ValuationHistoryProvider(itemId);
  }

  @override
  ValuationHistoryProvider getProviderOverride(
    covariant ValuationHistoryProvider provider,
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
  String? get name => r'valuationHistoryProvider';
}

/// See also [valuationHistory].
class ValuationHistoryProvider
    extends AutoDisposeFutureProvider<List<Valuation>> {
  /// See also [valuationHistory].
  ValuationHistoryProvider(String itemId)
    : this._internal(
        (ref) => valuationHistory(ref as ValuationHistoryRef, itemId),
        from: valuationHistoryProvider,
        name: r'valuationHistoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$valuationHistoryHash,
        dependencies: ValuationHistoryFamily._dependencies,
        allTransitiveDependencies:
            ValuationHistoryFamily._allTransitiveDependencies,
        itemId: itemId,
      );

  ValuationHistoryProvider._internal(
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
  Override overrideWith(
    FutureOr<List<Valuation>> Function(ValuationHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ValuationHistoryProvider._internal(
        (ref) => create(ref as ValuationHistoryRef),
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
  AutoDisposeFutureProviderElement<List<Valuation>> createElement() {
    return _ValuationHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ValuationHistoryProvider && other.itemId == itemId;
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
mixin ValuationHistoryRef on AutoDisposeFutureProviderRef<List<Valuation>> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _ValuationHistoryProviderElement
    extends AutoDisposeFutureProviderElement<List<Valuation>>
    with ValuationHistoryRef {
  _ValuationHistoryProviderElement(super.provider);

  @override
  String get itemId => (origin as ValuationHistoryProvider).itemId;
}

String _$latestValuationHash() => r'1d55889ab94225b7b4fc1c66fbbbb19285fdeac1';

/// See also [latestValuation].
@ProviderFor(latestValuation)
const latestValuationProvider = LatestValuationFamily();

/// See also [latestValuation].
class LatestValuationFamily extends Family<AsyncValue<Valuation?>> {
  /// See also [latestValuation].
  const LatestValuationFamily();

  /// See also [latestValuation].
  LatestValuationProvider call(String itemId) {
    return LatestValuationProvider(itemId);
  }

  @override
  LatestValuationProvider getProviderOverride(
    covariant LatestValuationProvider provider,
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
  String? get name => r'latestValuationProvider';
}

/// See also [latestValuation].
class LatestValuationProvider extends AutoDisposeFutureProvider<Valuation?> {
  /// See also [latestValuation].
  LatestValuationProvider(String itemId)
    : this._internal(
        (ref) => latestValuation(ref as LatestValuationRef, itemId),
        from: latestValuationProvider,
        name: r'latestValuationProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$latestValuationHash,
        dependencies: LatestValuationFamily._dependencies,
        allTransitiveDependencies:
            LatestValuationFamily._allTransitiveDependencies,
        itemId: itemId,
      );

  LatestValuationProvider._internal(
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
  Override overrideWith(
    FutureOr<Valuation?> Function(LatestValuationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LatestValuationProvider._internal(
        (ref) => create(ref as LatestValuationRef),
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
  AutoDisposeFutureProviderElement<Valuation?> createElement() {
    return _LatestValuationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LatestValuationProvider && other.itemId == itemId;
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
mixin LatestValuationRef on AutoDisposeFutureProviderRef<Valuation?> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _LatestValuationProviderElement
    extends AutoDisposeFutureProviderElement<Valuation?>
    with LatestValuationRef {
  _LatestValuationProviderElement(super.provider);

  @override
  String get itemId => (origin as LatestValuationProvider).itemId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
