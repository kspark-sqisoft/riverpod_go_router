import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class Theme extends _$Theme {
  @override
  ThemeState build() {
    return const LightTheme();
  }

  void toggleTheme() {
    state = switch (state) {
      LightTheme() => const DarkTheme(),
      DarkTheme() => const LightTheme(),
    };
  }

  void changeTheme(ThemeState themeState) {
    state = themeState;
  }
}

sealed class ThemeState {
  const ThemeState();
}

final class LightTheme extends ThemeState {
  const LightTheme();

  @override
  String toString() => 'LightTheme()';
}

final class DarkTheme extends ThemeState {
  const DarkTheme();

  @override
  String toString() => 'DarkTheme()';
}
