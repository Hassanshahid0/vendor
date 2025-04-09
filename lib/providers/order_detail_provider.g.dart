// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getUserDetailsHash() => r'7f1a07cdc1b0de20fc3a21fc97addc5f3191afde';

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

/// See also [getUserDetails].
@ProviderFor(getUserDetails)
const getUserDetailsProvider = GetUserDetailsFamily();

/// See also [getUserDetails].
class GetUserDetailsFamily extends Family<AsyncValue<UserModel>> {
  /// See also [getUserDetails].
  const GetUserDetailsFamily();

  /// See also [getUserDetails].
  GetUserDetailsProvider call(
    String userUID,
  ) {
    return GetUserDetailsProvider(
      userUID,
    );
  }

  @override
  GetUserDetailsProvider getProviderOverride(
    covariant GetUserDetailsProvider provider,
  ) {
    return call(
      provider.userUID,
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
  String? get name => r'getUserDetailsProvider';
}

/// See also [getUserDetails].
class GetUserDetailsProvider extends AutoDisposeFutureProvider<UserModel> {
  /// See also [getUserDetails].
  GetUserDetailsProvider(
    String userUID,
  ) : this._internal(
          (ref) => getUserDetails(
            ref as GetUserDetailsRef,
            userUID,
          ),
          from: getUserDetailsProvider,
          name: r'getUserDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUserDetailsHash,
          dependencies: GetUserDetailsFamily._dependencies,
          allTransitiveDependencies:
              GetUserDetailsFamily._allTransitiveDependencies,
          userUID: userUID,
        );

  GetUserDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userUID,
  }) : super.internal();

  final String userUID;

  @override
  Override overrideWith(
    FutureOr<UserModel> Function(GetUserDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetUserDetailsProvider._internal(
        (ref) => create(ref as GetUserDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userUID: userUID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserModel> createElement() {
    return _GetUserDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetUserDetailsProvider && other.userUID == userUID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userUID.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetUserDetailsRef on AutoDisposeFutureProviderRef<UserModel> {
  /// The parameter `userUID` of this provider.
  String get userUID;
}

class _GetUserDetailsProviderElement
    extends AutoDisposeFutureProviderElement<UserModel> with GetUserDetailsRef {
  _GetUserDetailsProviderElement(super.provider);

  @override
  String get userUID => (origin as GetUserDetailsProvider).userUID;
}

String _$getAdminCommissionHash() =>
    r'49e5867d12f962e95b18afaf29c5235a685e5eee';

/// See also [getAdminCommission].
@ProviderFor(getAdminCommission)
final getAdminCommissionProvider = AutoDisposeFutureProvider<num>.internal(
  getAdminCommission,
  name: r'getAdminCommissionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAdminCommissionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetAdminCommissionRef = AutoDisposeFutureProviderRef<num>;
String _$getWalletHash() => r'bd9bf1205b2d70c296f017d52ce9bb64784d89d5';

/// See also [getWallet].
@ProviderFor(getWallet)
const getWalletProvider = GetWalletFamily();

/// See also [getWallet].
class GetWalletFamily extends Family<AsyncValue<num>> {
  /// See also [getWallet].
  const GetWalletFamily();

  /// See also [getWallet].
  GetWalletProvider call(
    dynamic userUID,
  ) {
    return GetWalletProvider(
      userUID,
    );
  }

  @override
  GetWalletProvider getProviderOverride(
    covariant GetWalletProvider provider,
  ) {
    return call(
      provider.userUID,
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
  String? get name => r'getWalletProvider';
}

/// See also [getWallet].
class GetWalletProvider extends AutoDisposeFutureProvider<num> {
  /// See also [getWallet].
  GetWalletProvider(
    dynamic userUID,
  ) : this._internal(
          (ref) => getWallet(
            ref as GetWalletRef,
            userUID,
          ),
          from: getWalletProvider,
          name: r'getWalletProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getWalletHash,
          dependencies: GetWalletFamily._dependencies,
          allTransitiveDependencies: GetWalletFamily._allTransitiveDependencies,
          userUID: userUID,
        );

  GetWalletProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userUID,
  }) : super.internal();

  final dynamic userUID;

  @override
  Override overrideWith(
    FutureOr<num> Function(GetWalletRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetWalletProvider._internal(
        (ref) => create(ref as GetWalletRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userUID: userUID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<num> createElement() {
    return _GetWalletProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetWalletProvider && other.userUID == userUID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userUID.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetWalletRef on AutoDisposeFutureProviderRef<num> {
  /// The parameter `userUID` of this provider.
  dynamic get userUID;
}

class _GetWalletProviderElement extends AutoDisposeFutureProviderElement<num>
    with GetWalletRef {
  _GetWalletProviderElement(super.provider);

  @override
  dynamic get userUID => (origin as GetWalletProvider).userUID;
}

String _$getRiderChargeHash() => r'b170b4d48d56901b9e5d505b5d74eb6f862a6725';

/// See also [getRiderCharge].
@ProviderFor(getRiderCharge)
final getRiderChargeProvider = AutoDisposeFutureProvider<num>.internal(
  getRiderCharge,
  name: r'getRiderChargeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getRiderChargeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetRiderChargeRef = AutoDisposeFutureProviderRef<num>;
String _$fetchOrderDetailHash() => r'7b97fabbd3b8776d50a6000aa8ded19712701c76';

/// See also [fetchOrderDetail].
@ProviderFor(fetchOrderDetail)
const fetchOrderDetailProvider = FetchOrderDetailFamily();

/// See also [fetchOrderDetail].
class FetchOrderDetailFamily extends Family<AsyncValue<OrderModel2>> {
  /// See also [fetchOrderDetail].
  const FetchOrderDetailFamily();

  /// See also [fetchOrderDetail].
  FetchOrderDetailProvider call(
    String orderID,
  ) {
    return FetchOrderDetailProvider(
      orderID,
    );
  }

  @override
  FetchOrderDetailProvider getProviderOverride(
    covariant FetchOrderDetailProvider provider,
  ) {
    return call(
      provider.orderID,
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
  String? get name => r'fetchOrderDetailProvider';
}

/// See also [fetchOrderDetail].
class FetchOrderDetailProvider extends AutoDisposeStreamProvider<OrderModel2> {
  /// See also [fetchOrderDetail].
  FetchOrderDetailProvider(
    String orderID,
  ) : this._internal(
          (ref) => fetchOrderDetail(
            ref as FetchOrderDetailRef,
            orderID,
          ),
          from: fetchOrderDetailProvider,
          name: r'fetchOrderDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchOrderDetailHash,
          dependencies: FetchOrderDetailFamily._dependencies,
          allTransitiveDependencies:
              FetchOrderDetailFamily._allTransitiveDependencies,
          orderID: orderID,
        );

  FetchOrderDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderID,
  }) : super.internal();

  final String orderID;

  @override
  Override overrideWith(
    Stream<OrderModel2> Function(FetchOrderDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchOrderDetailProvider._internal(
        (ref) => create(ref as FetchOrderDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderID: orderID,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<OrderModel2> createElement() {
    return _FetchOrderDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchOrderDetailProvider && other.orderID == orderID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderID.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchOrderDetailRef on AutoDisposeStreamProviderRef<OrderModel2> {
  /// The parameter `orderID` of this provider.
  String get orderID;
}

class _FetchOrderDetailProviderElement
    extends AutoDisposeStreamProviderElement<OrderModel2>
    with FetchOrderDetailRef {
  _FetchOrderDetailProviderElement(super.provider);

  @override
  String get orderID => (origin as FetchOrderDetailProvider).orderID;
}

String _$getPercentageOfCouponHash() =>
    r'59b5dcd9fa080a93506dff323a9f79a0d863c37c';

/// See also [getPercentageOfCoupon].
@ProviderFor(getPercentageOfCoupon)
const getPercentageOfCouponProvider = GetPercentageOfCouponFamily();

/// See also [getPercentageOfCoupon].
class GetPercentageOfCouponFamily extends Family<double> {
  /// See also [getPercentageOfCoupon].
  const GetPercentageOfCouponFamily();

  /// See also [getPercentageOfCoupon].
  GetPercentageOfCouponProvider call(
    OrderModel2 orderModel,
  ) {
    return GetPercentageOfCouponProvider(
      orderModel,
    );
  }

  @override
  GetPercentageOfCouponProvider getProviderOverride(
    covariant GetPercentageOfCouponProvider provider,
  ) {
    return call(
      provider.orderModel,
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
  String? get name => r'getPercentageOfCouponProvider';
}

/// See also [getPercentageOfCoupon].
class GetPercentageOfCouponProvider extends AutoDisposeProvider<double> {
  /// See also [getPercentageOfCoupon].
  GetPercentageOfCouponProvider(
    OrderModel2 orderModel,
  ) : this._internal(
          (ref) => getPercentageOfCoupon(
            ref as GetPercentageOfCouponRef,
            orderModel,
          ),
          from: getPercentageOfCouponProvider,
          name: r'getPercentageOfCouponProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPercentageOfCouponHash,
          dependencies: GetPercentageOfCouponFamily._dependencies,
          allTransitiveDependencies:
              GetPercentageOfCouponFamily._allTransitiveDependencies,
          orderModel: orderModel,
        );

  GetPercentageOfCouponProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderModel,
  }) : super.internal();

  final OrderModel2 orderModel;

  @override
  Override overrideWith(
    double Function(GetPercentageOfCouponRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPercentageOfCouponProvider._internal(
        (ref) => create(ref as GetPercentageOfCouponRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderModel: orderModel,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<double> createElement() {
    return _GetPercentageOfCouponProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPercentageOfCouponProvider &&
        other.orderModel == orderModel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderModel.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetPercentageOfCouponRef on AutoDisposeProviderRef<double> {
  /// The parameter `orderModel` of this provider.
  OrderModel2 get orderModel;
}

class _GetPercentageOfCouponProviderElement
    extends AutoDisposeProviderElement<double> with GetPercentageOfCouponRef {
  _GetPercentageOfCouponProviderElement(super.provider);

  @override
  OrderModel2 get orderModel =>
      (origin as GetPercentageOfCouponProvider).orderModel;
}

String _$updateWalletHash() => r'ea4b5e93698a80fb9f24beb6aff0e8382b71b16f';

/// See also [updateWallet].
@ProviderFor(updateWallet)
const updateWalletProvider = UpdateWalletFamily();

/// See also [updateWallet].
class UpdateWalletFamily extends Family<Object?> {
  /// See also [updateWallet].
  const UpdateWalletFamily();

  /// See also [updateWallet].
  UpdateWalletProvider call(
    OrderModel2 orderModel,
  ) {
    return UpdateWalletProvider(
      orderModel,
    );
  }

  @override
  UpdateWalletProvider getProviderOverride(
    covariant UpdateWalletProvider provider,
  ) {
    return call(
      provider.orderModel,
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
  String? get name => r'updateWalletProvider';
}

/// See also [updateWallet].
class UpdateWalletProvider extends AutoDisposeProvider<Object?> {
  /// See also [updateWallet].
  UpdateWalletProvider(
    OrderModel2 orderModel,
  ) : this._internal(
          (ref) => updateWallet(
            ref as UpdateWalletRef,
            orderModel,
          ),
          from: updateWalletProvider,
          name: r'updateWalletProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateWalletHash,
          dependencies: UpdateWalletFamily._dependencies,
          allTransitiveDependencies:
              UpdateWalletFamily._allTransitiveDependencies,
          orderModel: orderModel,
        );

  UpdateWalletProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderModel,
  }) : super.internal();

  final OrderModel2 orderModel;

  @override
  Override overrideWith(
    Object? Function(UpdateWalletRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateWalletProvider._internal(
        (ref) => create(ref as UpdateWalletRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderModel: orderModel,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Object?> createElement() {
    return _UpdateWalletProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateWalletProvider && other.orderModel == orderModel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderModel.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateWalletRef on AutoDisposeProviderRef<Object?> {
  /// The parameter `orderModel` of this provider.
  OrderModel2 get orderModel;
}

class _UpdateWalletProviderElement extends AutoDisposeProviderElement<Object?>
    with UpdateWalletRef {
  _UpdateWalletProviderElement(super.provider);

  @override
  OrderModel2 get orderModel => (origin as UpdateWalletProvider).orderModel;
}

String _$updateStatusHash() => r'0812785bfeef7b28730d7a4c32dd9d793e25e2b0';

/// See also [updateStatus].
@ProviderFor(updateStatus)
const updateStatusProvider = UpdateStatusFamily();

/// See also [updateStatus].
class UpdateStatusFamily extends Family<AsyncValue<void>> {
  /// See also [updateStatus].
  const UpdateStatusFamily();

  /// See also [updateStatus].
  UpdateStatusProvider call(
    String orderStatus,
    OrderModel2 orderModel,
    BuildContext context,
    String userToken,
    String notificationID,
  ) {
    return UpdateStatusProvider(
      orderStatus,
      orderModel,
      context,
      userToken,
      notificationID,
    );
  }

  @override
  UpdateStatusProvider getProviderOverride(
    covariant UpdateStatusProvider provider,
  ) {
    return call(
      provider.orderStatus,
      provider.orderModel,
      provider.context,
      provider.userToken,
      provider.notificationID,
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
  String? get name => r'updateStatusProvider';
}

/// See also [updateStatus].
class UpdateStatusProvider extends AutoDisposeFutureProvider<void> {
  /// See also [updateStatus].
  UpdateStatusProvider(
    String orderStatus,
    OrderModel2 orderModel,
    BuildContext context,
    String userToken,
    String notificationID,
  ) : this._internal(
          (ref) => updateStatus(
            ref as UpdateStatusRef,
            orderStatus,
            orderModel,
            context,
            userToken,
            notificationID,
          ),
          from: updateStatusProvider,
          name: r'updateStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateStatusHash,
          dependencies: UpdateStatusFamily._dependencies,
          allTransitiveDependencies:
              UpdateStatusFamily._allTransitiveDependencies,
          orderStatus: orderStatus,
          orderModel: orderModel,
          context: context,
          userToken: userToken,
          notificationID: notificationID,
        );

  UpdateStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderStatus,
    required this.orderModel,
    required this.context,
    required this.userToken,
    required this.notificationID,
  }) : super.internal();

  final String orderStatus;
  final OrderModel2 orderModel;
  final BuildContext context;
  final String userToken;
  final String notificationID;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateStatusProvider._internal(
        (ref) => create(ref as UpdateStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderStatus: orderStatus,
        orderModel: orderModel,
        context: context,
        userToken: userToken,
        notificationID: notificationID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateStatusProvider &&
        other.orderStatus == orderStatus &&
        other.orderModel == orderModel &&
        other.context == context &&
        other.userToken == userToken &&
        other.notificationID == notificationID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderStatus.hashCode);
    hash = _SystemHash.combine(hash, orderModel.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, userToken.hashCode);
    hash = _SystemHash.combine(hash, notificationID.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateStatusRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `orderStatus` of this provider.
  String get orderStatus;

  /// The parameter `orderModel` of this provider.
  OrderModel2 get orderModel;

  /// The parameter `context` of this provider.
  BuildContext get context;

  /// The parameter `userToken` of this provider.
  String get userToken;

  /// The parameter `notificationID` of this provider.
  String get notificationID;
}

class _UpdateStatusProviderElement
    extends AutoDisposeFutureProviderElement<void> with UpdateStatusRef {
  _UpdateStatusProviderElement(super.provider);

  @override
  String get orderStatus => (origin as UpdateStatusProvider).orderStatus;
  @override
  OrderModel2 get orderModel => (origin as UpdateStatusProvider).orderModel;
  @override
  BuildContext get context => (origin as UpdateStatusProvider).context;
  @override
  String get userToken => (origin as UpdateStatusProvider).userToken;
  @override
  String get notificationID => (origin as UpdateStatusProvider).notificationID;
}

String _$getRidersHash() => r'ad072dc1ae77a098b02d100d9147be54a9fb36c4';

/// See also [getRiders].
@ProviderFor(getRiders)
final getRidersProvider = AutoDisposeStreamProvider<List<UserModel>>.internal(
  getRiders,
  name: r'getRidersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getRidersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetRidersRef = AutoDisposeStreamProviderRef<List<UserModel>>;
String _$assignRiderHash() => r'1bf1d801666558cd7f3948acda71a1e431023541';

/// See also [assignRider].
@ProviderFor(assignRider)
const assignRiderProvider = AssignRiderFamily();

/// See also [assignRider].
class AssignRiderFamily extends Family<AsyncValue<void>> {
  /// See also [assignRider].
  const AssignRiderFamily();

  /// See also [assignRider].
  AssignRiderProvider call(
    String rider,
    OrderModel2 orderModel,
    BuildContext context,
  ) {
    return AssignRiderProvider(
      rider,
      orderModel,
      context,
    );
  }

  @override
  AssignRiderProvider getProviderOverride(
    covariant AssignRiderProvider provider,
  ) {
    return call(
      provider.rider,
      provider.orderModel,
      provider.context,
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
  String? get name => r'assignRiderProvider';
}

/// See also [assignRider].
class AssignRiderProvider extends AutoDisposeFutureProvider<void> {
  /// See also [assignRider].
  AssignRiderProvider(
    String rider,
    OrderModel2 orderModel,
    BuildContext context,
  ) : this._internal(
          (ref) => assignRider(
            ref as AssignRiderRef,
            rider,
            orderModel,
            context,
          ),
          from: assignRiderProvider,
          name: r'assignRiderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$assignRiderHash,
          dependencies: AssignRiderFamily._dependencies,
          allTransitiveDependencies:
              AssignRiderFamily._allTransitiveDependencies,
          rider: rider,
          orderModel: orderModel,
          context: context,
        );

  AssignRiderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.rider,
    required this.orderModel,
    required this.context,
  }) : super.internal();

  final String rider;
  final OrderModel2 orderModel;
  final BuildContext context;

  @override
  Override overrideWith(
    FutureOr<void> Function(AssignRiderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AssignRiderProvider._internal(
        (ref) => create(ref as AssignRiderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        rider: rider,
        orderModel: orderModel,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _AssignRiderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AssignRiderProvider &&
        other.rider == rider &&
        other.orderModel == orderModel &&
        other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, rider.hashCode);
    hash = _SystemHash.combine(hash, orderModel.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AssignRiderRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `rider` of this provider.
  String get rider;

  /// The parameter `orderModel` of this provider.
  OrderModel2 get orderModel;

  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _AssignRiderProviderElement extends AutoDisposeFutureProviderElement<void>
    with AssignRiderRef {
  _AssignRiderProviderElement(super.provider);

  @override
  String get rider => (origin as AssignRiderProvider).rider;
  @override
  OrderModel2 get orderModel => (origin as AssignRiderProvider).orderModel;
  @override
  BuildContext get context => (origin as AssignRiderProvider).context;
}

String _$cancelRiderHash() => r'51686b161ad0fd672081853caa02c39543ba5ea5';

/// See also [cancelRider].
@ProviderFor(cancelRider)
const cancelRiderProvider = CancelRiderFamily();

/// See also [cancelRider].
class CancelRiderFamily extends Family<AsyncValue<void>> {
  /// See also [cancelRider].
  const CancelRiderFamily();

  /// See also [cancelRider].
  CancelRiderProvider call(
    OrderModel2 orderModel,
    BuildContext context,
  ) {
    return CancelRiderProvider(
      orderModel,
      context,
    );
  }

  @override
  CancelRiderProvider getProviderOverride(
    covariant CancelRiderProvider provider,
  ) {
    return call(
      provider.orderModel,
      provider.context,
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
  String? get name => r'cancelRiderProvider';
}

/// See also [cancelRider].
class CancelRiderProvider extends AutoDisposeFutureProvider<void> {
  /// See also [cancelRider].
  CancelRiderProvider(
    OrderModel2 orderModel,
    BuildContext context,
  ) : this._internal(
          (ref) => cancelRider(
            ref as CancelRiderRef,
            orderModel,
            context,
          ),
          from: cancelRiderProvider,
          name: r'cancelRiderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cancelRiderHash,
          dependencies: CancelRiderFamily._dependencies,
          allTransitiveDependencies:
              CancelRiderFamily._allTransitiveDependencies,
          orderModel: orderModel,
          context: context,
        );

  CancelRiderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderModel,
    required this.context,
  }) : super.internal();

  final OrderModel2 orderModel;
  final BuildContext context;

  @override
  Override overrideWith(
    FutureOr<void> Function(CancelRiderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CancelRiderProvider._internal(
        (ref) => create(ref as CancelRiderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderModel: orderModel,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _CancelRiderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CancelRiderProvider &&
        other.orderModel == orderModel &&
        other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderModel.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CancelRiderRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `orderModel` of this provider.
  OrderModel2 get orderModel;

  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _CancelRiderProviderElement extends AutoDisposeFutureProviderElement<void>
    with CancelRiderRef {
  _CancelRiderProviderElement(super.provider);

  @override
  OrderModel2 get orderModel => (origin as CancelRiderProvider).orderModel;
  @override
  BuildContext get context => (origin as CancelRiderProvider).context;
}

String _$getRiderDetailHash() => r'1d8e43fbea9924dbbfac5b2e0e3e75fc9e0aa23c';

/// See also [getRiderDetail].
@ProviderFor(getRiderDetail)
const getRiderDetailProvider = GetRiderDetailFamily();

/// See also [getRiderDetail].
class GetRiderDetailFamily extends Family<AsyncValue<UserModel>> {
  /// See also [getRiderDetail].
  const GetRiderDetailFamily();

  /// See also [getRiderDetail].
  GetRiderDetailProvider call(
    OrderModel2 orderModel,
  ) {
    return GetRiderDetailProvider(
      orderModel,
    );
  }

  @override
  GetRiderDetailProvider getProviderOverride(
    covariant GetRiderDetailProvider provider,
  ) {
    return call(
      provider.orderModel,
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
  String? get name => r'getRiderDetailProvider';
}

/// See also [getRiderDetail].
class GetRiderDetailProvider extends AutoDisposeFutureProvider<UserModel> {
  /// See also [getRiderDetail].
  GetRiderDetailProvider(
    OrderModel2 orderModel,
  ) : this._internal(
          (ref) => getRiderDetail(
            ref as GetRiderDetailRef,
            orderModel,
          ),
          from: getRiderDetailProvider,
          name: r'getRiderDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getRiderDetailHash,
          dependencies: GetRiderDetailFamily._dependencies,
          allTransitiveDependencies:
              GetRiderDetailFamily._allTransitiveDependencies,
          orderModel: orderModel,
        );

  GetRiderDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderModel,
  }) : super.internal();

  final OrderModel2 orderModel;

  @override
  Override overrideWith(
    FutureOr<UserModel> Function(GetRiderDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetRiderDetailProvider._internal(
        (ref) => create(ref as GetRiderDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderModel: orderModel,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserModel> createElement() {
    return _GetRiderDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetRiderDetailProvider && other.orderModel == orderModel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderModel.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetRiderDetailRef on AutoDisposeFutureProviderRef<UserModel> {
  /// The parameter `orderModel` of this provider.
  OrderModel2 get orderModel;
}

class _GetRiderDetailProviderElement
    extends AutoDisposeFutureProviderElement<UserModel> with GetRiderDetailRef {
  _GetRiderDetailProviderElement(super.provider);

  @override
  OrderModel2 get orderModel => (origin as GetRiderDetailProvider).orderModel;
}

String _$getEnableRiderStatusDetailsHash() =>
    r'441590ae2da4c0448834dd1bc00aef3f5ba6e6de';

/// See also [getEnableRiderStatusDetails].
@ProviderFor(getEnableRiderStatusDetails)
final getEnableRiderStatusDetailsProvider =
    AutoDisposeFutureProvider<bool>.internal(
  getEnableRiderStatusDetails,
  name: r'getEnableRiderStatusDetailsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getEnableRiderStatusDetailsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetEnableRiderStatusDetailsRef = AutoDisposeFutureProviderRef<bool>;
String _$getEmailDetailsHash() => r'76dd93a626ee81c775ae9da298223128e255b70f';

/// See also [getEmailDetails].
@ProviderFor(getEmailDetails)
final getEmailDetailsProvider = AutoDisposeFutureProvider<String>.internal(
  getEmailDetails,
  name: r'getEmailDetailsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getEmailDetailsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetEmailDetailsRef = AutoDisposeFutureProviderRef<String>;
String _$loadingProviderHash() => r'0d416f690c69fcae00ebd8e2cbfc0f5ee58125f7';

/// See also [LoadingProvider].
@ProviderFor(LoadingProvider)
final loadingProviderProvider =
    AutoDisposeNotifierProvider<LoadingProvider, bool>.internal(
  LoadingProvider.new,
  name: r'loadingProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loadingProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoadingProvider = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
