import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_go_router/pages/weather/repositories/weather_repository.dart';
import 'package:riverpod_go_router/pages/weather/services/weather_api_services_provider.dart';

part 'weather_repository_provider.g.dart';

@riverpod
WeatherRepository weatherRepository(WeatherRepositoryRef ref) {
  return WeatherRepository(
    weatherApiServices: ref.watch(weatherApiServicesProvider),
  );
}
