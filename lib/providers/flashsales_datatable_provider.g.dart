// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashsales_datatable_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$flashsalesStreamHash() => r'f9aa73e400c4a720937f0c16714b5b1729a8b109';

/// See also [flashsalesStream].
@ProviderFor(flashsalesStream)
final flashsalesStreamProvider =
    AutoDisposeStreamProvider<List<ProductsModel>>.internal(
  flashsalesStream,
  name: r'flashsalesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$flashsalesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FlashsalesStreamRef = AutoDisposeStreamProviderRef<List<ProductsModel>>;
String _$currencySymbolHash() => r'72be8099077ffefee37713c8cfdc69ebdbcd0cf4';

/// See also [currencySymbol].
@ProviderFor(currencySymbol)
final currencySymbolProvider = AutoDisposeFutureProvider<String>.internal(
  currencySymbol,
  name: r'currencySymbolProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currencySymbolHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrencySymbolRef = AutoDisposeFutureProviderRef<String>;
String _$flashSalesTimeStreamHash() =>
    r'37b089fe4ed52069491ce7dabf7d9e2fd57dda2d';

/// See also [flashSalesTimeStream].
@ProviderFor(flashSalesTimeStream)
final flashSalesTimeStreamProvider = AutoDisposeStreamProvider<String>.internal(
  flashSalesTimeStream,
  name: r'flashSalesTimeStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$flashSalesTimeStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FlashSalesTimeStreamRef = AutoDisposeStreamProviderRef<String>;
String _$setFlashSalesTimeHash() => r'717ad1aea7e18c1fa17c3df7ddd7fec93ac4ff95';

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

/// See also [setFlashSalesTime].
@ProviderFor(setFlashSalesTime)
const setFlashSalesTimeProvider = SetFlashSalesTimeFamily();

/// See also [setFlashSalesTime].
class SetFlashSalesTimeFamily extends Family<AsyncValue<void>> {
  /// See also [setFlashSalesTime].
  const SetFlashSalesTimeFamily();

  /// See also [setFlashSalesTime].
  SetFlashSalesTimeProvider call(
    String flashSalesTime,
  ) {
    return SetFlashSalesTimeProvider(
      flashSalesTime,
    );
  }

  @override
  SetFlashSalesTimeProvider getProviderOverride(
    covariant SetFlashSalesTimeProvider provider,
  ) {
    return call(
      provider.flashSalesTime,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'setFlashSalesTimeProvider';
}

/// See also [setFlashSalesTime].
class SetFlashSalesTimeProvider extends AutoDisposeFutureProvider<void> {
  /// See also [setFlashSalesTime].
  SetFlashSalesTimeProvider(
    String flashSalesTime,
  ) : this._internal(
          (ref) => setFlashSalesTime(
            ref as SetFlashSalesTimeRef,
            flashSalesTime,
          ),
          from: setFlashSalesTimeProvider,
          name: r'setFlashSalesTimeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setFlashSalesTimeHash,
          dependencies: SetFlashSalesTimeFamily._dependencies,
          allTransitiveDependencies:
              SetFlashSalesTimeFamily._allTransitiveDependencies,
          flashSalesTime: flashSalesTime,
        );

  SetFlashSalesTimeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.flashSalesTime,
  }) : super.internal();

  final String flashSalesTime;

  @override
  Override overrideWith(
    FutureOr<void> Function(SetFlashSalesTimeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SetFlashSalesTimeProvider._internal(
        (ref) => create(ref as SetFlashSalesTimeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        flashSalesTime: flashSalesTime,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SetFlashSalesTimeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetFlashSalesTimeProvider &&
        other.flashSalesTime == flashSalesTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, flashSalesTime.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SetFlashSalesTimeRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `flashSalesTime` of this provider.
  String get flashSalesTime;
}

class _SetFlashSalesTimeProviderElement
    extends AutoDisposeFutureProviderElement<void> with SetFlashSalesTimeRef {
  _SetFlashSalesTimeProviderElement(super.provider);

  @override
  String get flashSalesTime =>
      (origin as SetFlashSalesTimeProvider).flashSalesTime;
}

String _$deleteFlashSalesCollectionHash() =>
    r'7a01efe3e848891564922fc84c97f15fef3daba3';

/// See also [deleteFlashSalesCollection].
@ProviderFor(deleteFlashSalesCollection)
final deleteFlashSalesCollectionProvider =
    AutoDisposeFutureProvider<void>.internal(
  deleteFlashSalesCollection,
  name: r'deleteFlashSalesCollectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteFlashSalesCollectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeleteFlashSalesCollectionRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
