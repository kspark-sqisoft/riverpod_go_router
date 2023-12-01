import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_go_router/main.dart';
import 'package:riverpod_go_router/pages/weather/constants/constants.dart';
import 'package:riverpod_go_router/pages/weather/errors/custom_error.dart';
import 'package:riverpod_go_router/pages/weather/models/current_weather/app_weather.dart';
import 'package:riverpod_go_router/pages/weather/models/current_weather/current_weather.dart';
import 'package:riverpod_go_router/pages/weather/providers/weather_provider.dart';
import 'package:riverpod_go_router/pages/weather/services/weather_api_services_provider.dart';
import 'package:riverpod_go_router/pages/weather/widgets/show_weather.dart';
import 'package:riverpod_go_router/providers/auth_state_provider.dart';
import 'package:riverpod_go_router/providers/theme_provider.dart';
import 'package:riverpod_go_router/router/route_names.dart';

class WeatherPage extends ConsumerStatefulWidget {
  const WeatherPage({super.key});

  @override
  ConsumerState<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends ConsumerState<WeatherPage> {
  bool loading = false;
  String? city;

  @override
  void initState() {
    print('WeatherPage initState');
    getInitialLocation();
    super.initState();
  }

  void getInitialLocation() async {
    bool serviceEnabled;
    setState(() => loading = true);
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    try {
      final pos = await Geolocator.getCurrentPosition();
      city = await ref
          .read(weatherApiServicesProvider)
          .getReverseGeocoding(pos.latitude, pos.longitude);
      print('city:$city');
    } catch (e) {
      city = kDefaultLocation;
    } finally {
      setState(() => loading = false);
    }
    ref.read(weatherProvider.notifier).fetchWeather(city!);
  }

  @override
  void dispose() {
    print('WeatherPage dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<CurrentWeather?>>(
      weatherProvider,
      (previous, next) {
        next.whenOrNull(
          data: (CurrentWeather? currentWeather) {
            if (currentWeather == null) {
              return;
            }
            final weather = AppWeather.fromCurrentWeather(currentWeather);

            if (weather.temp < kWarmOrNot) {
              ref.read(themeProvider.notifier).changeTheme(const DarkTheme());
            } else {
              ref.read(themeProvider.notifier).changeTheme(const LightTheme());
            }
          },
          error: (error, stackTrace) {
            errorDialog(context, (error as CustomError).errMsg);
          },
        );
      },
    );

    ref.listen(changeRouteProvider, (p, n) {
      if (n.routeType == ChangeRouteType.going && n.routeName == '/weather') {
        if (city != null) {
          ref.read(weatherProvider.notifier).fetchWeather(city.toString());
        }
      }
      if (n.routeType == ChangeRouteType.restoring &&
          n.routeName == '/weather') {
        if (city != null) {
          ref.read(weatherProvider.notifier).fetchWeather(city.toString());
        }
      }
    });

    final weatherState = ref.watch(weatherProvider);

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          if (city != null) {
            ref.read(weatherProvider.notifier).fetchWeather(city.toString());
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'WEATHER',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final city = await context
                                .pushNamed<String>(RouteNames.weathersearch);
                            print('search city:$city');
                            if (city != null) {
                              ref
                                  .read(weatherProvider.notifier)
                                  .fetchWeather(city.toString());
                            }
                          },
                          icon: const Icon(Icons.search),
                        ),
                        IconButton(
                          onPressed: () {
                            //ref.invalidate(weatherProvider);
                            if (city != null) {
                              ref
                                  .read(weatherProvider.notifier)
                                  .fetchWeather(city.toString());
                            }
                          },
                          icon: const Icon(Icons.refresh),
                        ),
                        IconButton(
                          onPressed: () {
                            context.pushNamed(RouteNames.weathertempsettings);
                          },
                          icon: const Icon(Icons.settings),
                        ),
                        IconButton(
                          onPressed: () {
                            ref.read(themeProvider.notifier).toggleTheme();
                          },
                          icon: const Icon(Icons.light_mode),
                        ),
                      ],
                    )
                  ],
                ),
                //내용
                Expanded(
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ShowWeather(weatherState: weatherState),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await ref
                  .watch(authStateProvider.notifier)
                  .setAuthenticate(false);
            },
            icon: const Icon(Icons.exit_to_app),
            label: const Text('Sign Out'),
          ),
        ),
      ),
    );
  }
}

void errorDialog(BuildContext context, String errorMessage) {
  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
