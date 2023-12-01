import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'temp_settings_provider.g.dart';

@Riverpod(keepAlive: true)
class TempSettings extends _$TempSettings {
  @override
  TempSettingsState build() {
    print('[tempSettingsProvider] initialized');
    ref.onDispose(() {
      print('[tempSettingsProvider] disposed');
    });
    return const Celsius();
  }

  void toggleTempUnit() {
    state = switch (state) {
      Celsius() => const Fahrenheit(),
      Fahrenheit() => const Celsius(),
    };
  }
}

sealed class TempSettingsState {
  const TempSettingsState();
}

final class Celsius extends TempSettingsState {
  const Celsius();

  @override
  String toString() => 'Celsius()';
}

final class Fahrenheit extends TempSettingsState {
  const Fahrenheit();

  @override
  String toString() => 'Fahrenheit()';
}
