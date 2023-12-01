// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getProductsHash() => r'84b9c3816a28e466dacce97c476cf8c6accc6aa5';

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

/// See also [getProducts].
@ProviderFor(getProducts)
const getProductsProvider = GetProductsFamily();

/// See also [getProducts].
class GetProductsFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [getProducts].
  const GetProductsFamily();

  /// See also [getProducts].
  GetProductsProvider call(
    int page,
  ) {
    return GetProductsProvider(
      page,
    );
  }

  @override
  GetProductsProvider getProviderOverride(
    covariant GetProductsProvider provider,
  ) {
    return call(
      provider.page,
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
  String? get name => r'getProductsProvider';
}

/// See also [getProducts].
class GetProductsProvider extends AutoDisposeFutureProvider<List<Product>> {
  /// See also [getProducts].
  GetProductsProvider(
    int page,
  ) : this._internal(
          (ref) => getProducts(
            ref as GetProductsRef,
            page,
          ),
          from: getProductsProvider,
          name: r'getProductsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getProductsHash,
          dependencies: GetProductsFamily._dependencies,
          allTransitiveDependencies:
              GetProductsFamily._allTransitiveDependencies,
          page: page,
        );

  GetProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
  }) : super.internal();

  final int page;

  @override
  Override overrideWith(
    FutureOr<List<Product>> Function(GetProductsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetProductsProvider._internal(
        (ref) => create(ref as GetProductsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Product>> createElement() {
    return _GetProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetProductsProvider && other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetProductsRef on AutoDisposeFutureProviderRef<List<Product>> {
  /// The parameter `page` of this provider.
  int get page;
}

class _GetProductsProviderElement
    extends AutoDisposeFutureProviderElement<List<Product>>
    with GetProductsRef {
  _GetProductsProviderElement(super.provider);

  @override
  int get page => (origin as GetProductsProvider).page;
}

String _$getProductHash() => r'0dbe68bb96f99c530185593e5f4a19fd8ec2efbb';

/// See also [getProduct].
@ProviderFor(getProduct)
const getProductProvider = GetProductFamily();

/// See also [getProduct].
class GetProductFamily extends Family<AsyncValue<Product>> {
  /// See also [getProduct].
  const GetProductFamily();

  /// See also [getProduct].
  GetProductProvider call(
    int id,
  ) {
    return GetProductProvider(
      id,
    );
  }

  @override
  GetProductProvider getProviderOverride(
    covariant GetProductProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'getProductProvider';
}

/// See also [getProduct].
class GetProductProvider extends AutoDisposeFutureProvider<Product> {
  /// See also [getProduct].
  GetProductProvider(
    int id,
  ) : this._internal(
          (ref) => getProduct(
            ref as GetProductRef,
            id,
          ),
          from: getProductProvider,
          name: r'getProductProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getProductHash,
          dependencies: GetProductFamily._dependencies,
          allTransitiveDependencies:
              GetProductFamily._allTransitiveDependencies,
          id: id,
        );

  GetProductProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<Product> Function(GetProductRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetProductProvider._internal(
        (ref) => create(ref as GetProductRef),
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
  AutoDisposeFutureProviderElement<Product> createElement() {
    return _GetProductProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetProductProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetProductRef on AutoDisposeFutureProviderRef<Product> {
  /// The parameter `id` of this provider.
  int get id;
}

class _GetProductProviderElement
    extends AutoDisposeFutureProviderElement<Product> with GetProductRef {
  _GetProductProviderElement(super.provider);

  @override
  int get id => (origin as GetProductProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
