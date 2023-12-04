// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherHash() => r'4bf3cdeda05cde65914231ecb18a50b73715fbe9';

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

abstract class _$Weather
    extends BuildlessAutoDisposeAsyncNotifier<CurrentWeather?> {
  late final String? city;

  FutureOr<CurrentWeather?> build(
    String? city,
  );
}

/// See also [Weather].
@ProviderFor(Weather)
const weatherProvider = WeatherFamily();

/// See also [Weather].
class WeatherFamily extends Family<AsyncValue<CurrentWeather?>> {
  /// See also [Weather].
  const WeatherFamily();

  /// See also [Weather].
  WeatherProvider call(
    String? city,
  ) {
    return WeatherProvider(
      city,
    );
  }

  @override
  WeatherProvider getProviderOverride(
    covariant WeatherProvider provider,
  ) {
    return call(
      provider.city,
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
  String? get name => r'weatherProvider';
}

/// See also [Weather].
class WeatherProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Weather, CurrentWeather?> {
  /// See also [Weather].
  WeatherProvider(
    String? city,
  ) : this._internal(
          () => Weather()..city = city,
          from: weatherProvider,
          name: r'weatherProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$weatherHash,
          dependencies: WeatherFamily._dependencies,
          allTransitiveDependencies: WeatherFamily._allTransitiveDependencies,
          city: city,
        );

  WeatherProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.city,
  }) : super.internal();

  final String? city;

  @override
  FutureOr<CurrentWeather?> runNotifierBuild(
    covariant Weather notifier,
  ) {
    return notifier.build(
      city,
    );
  }

  @override
  Override overrideWith(Weather Function() create) {
    return ProviderOverride(
      origin: this,
      override: WeatherProvider._internal(
        () => create()..city = city,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        city: city,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Weather, CurrentWeather?>
      createElement() {
    return _WeatherProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WeatherProvider && other.city == city;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, city.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WeatherRef on AutoDisposeAsyncNotifierProviderRef<CurrentWeather?> {
  /// The parameter `city` of this provider.
  String? get city;
}

class _WeatherProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Weather, CurrentWeather?>
    with WeatherRef {
  _WeatherProviderElement(super.provider);

  @override
  String? get city => (origin as WeatherProvider).city;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
