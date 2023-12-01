import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_go_router/pages/weather/errors/custom_error.dart';
import 'package:riverpod_go_router/pages/weather/models/current_weather/app_weather.dart';
import 'package:riverpod_go_router/pages/weather/models/current_weather/current_weather.dart';
import 'package:riverpod_go_router/pages/weather/widgets/format_text.dart';
import 'package:riverpod_go_router/pages/weather/widgets/select_city.dart';
import 'package:riverpod_go_router/pages/weather/widgets/show_icon.dart';
import 'package:riverpod_go_router/pages/weather/widgets/show_temperature.dart';

class ShowWeather extends ConsumerWidget {
  final AsyncValue<CurrentWeather?> weatherState;
  const ShowWeather({
    super.key,
    required this.weatherState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return weatherState.when(
      skipError: true,
      data: (CurrentWeather? weather) {
        print('***** in data callback');

        if (weather == null) {
          return const SelectCity();
        }

        final appWeather = AppWeather.fromCurrentWeather(weather);

        return ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Text(
              appWeather.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TimeOfDay.fromDateTime(DateTime.now()).format(context),
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(width: 10.0),
                Text(
                  '(${appWeather.country})',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShowTemperature(
                  temperature: appWeather.temp,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShowTemperature(
                      temperature: appWeather.tempMax,
                      fontSize: 16.0,
                      label: '최고',
                    ),
                    const SizedBox(height: 10),
                    ShowTemperature(
                      temperature: appWeather.tempMin,
                      fontSize: 16.0,
                      label: '최저',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Spacer(),
                ShowIcon(icon: appWeather.icon),
                Expanded(
                  flex: 3,
                  child: FormatText(description: appWeather.description),
                ),
                const Spacer(),
              ],
            ),
          ],
        );
      },
      error: (error, stackTrace) {
        print('***** in error callback');
        if (weatherState.value == null) {
          return const SelectCity();
        }

        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              (error as CustomError).errMsg,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        );
      },
      loading: () {
        print('***** in loading callback');
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
