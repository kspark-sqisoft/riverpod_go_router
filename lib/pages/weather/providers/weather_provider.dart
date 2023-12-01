import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_go_router/pages/weather/models/current_weather/current_weather.dart';
import 'package:riverpod_go_router/pages/weather/repositories/weather_repository_provider.dart';

part 'weather_provider.g.dart';

@riverpod
class Weather extends _$Weather {
  Object? key;

  @override
  FutureOr<CurrentWeather?> build() {
    key = Object();
    ref.onDispose(() {
      key = null;
    });
    return Future<CurrentWeather?>.value(null);
  }

  Future<void> fetchWeather(String city) async {
    state = const AsyncLoading();

    final key = this.key;
    final newState = await AsyncValue.guard(() async {
      final currentWeather =
          await ref.read(weatherRepositoryProvider).fetchWeather(city);

      return currentWeather;
    });
    if (key == this.key) {
      state = newState;
    }
  }
}
