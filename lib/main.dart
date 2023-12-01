import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:media_kit/media_kit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_go_router/pages/todos/repositories/hive_todo_repository.dart';
import 'package:riverpod_go_router/pages/todos/repositories/todo_repository_provider.dart';
import 'package:riverpod_go_router/providers/theme_provider.dart';
import 'package:riverpod_go_router/router/router_shell_provider.dart';
import 'package:riverpod_go_router/router/router_state_full_shell_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'main.g.dart';
part 'main.freezed.dart';

@riverpod
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError();
}

enum ChangeRouteType {
  going,
  restoring,
}

@freezed
class ChangeRouteState with _$ChangeRouteState {
  const factory ChangeRouteState({
    @Default(ChangeRouteType.restoring) ChangeRouteType routeType,
    @Default('') String routeName,
  }) = _ChangeRouteState;
}

@riverpod
class ChangeRoute extends _$ChangeRoute {
  @override
  ChangeRouteState build() {
    return const ChangeRouteState();
  }

  void changeRoute(
      {required ChangeRouteType changeRouteType, required String routeName}) {
    state = ChangeRouteState(
      routeType: changeRouteType,
      routeName: routeName,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await dotenv.load(fileName: '.env');

  await Hive.initFlutter();
  await Hive.openBox('todos');

  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        todoRepositoryProvider.overrideWithValue(HiveTodoRepository())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  String lastLocation = '';

  void changeRoute() {
    GoRouter router = ref.read(routeStateFullShellProvider);
    print(
        '=====>${router.routerDelegate.currentConfiguration.last.matchedLocation}');
    final currentLocation =
        router.routerDelegate.currentConfiguration.last.matchedLocation;
    if (currentLocation == lastLocation) {
      //같은 페이지 (무언가 초기화)
      print('going==============');
      ref.read(changeRouteProvider.notifier).changeRoute(
          changeRouteType: ChangeRouteType.going, routeName: currentLocation);
    } else {
      //다른 페이지 이동시 (유지)
      print('restoring=============');
      ref.read(changeRouteProvider.notifier).changeRoute(
          changeRouteType: ChangeRouteType.restoring,
          routeName: currentLocation);
    }
    lastLocation =
        router.routerDelegate.currentConfiguration.last.matchedLocation;
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeProvider);
    //ShellRoute 상태 유지 X
    //final router = ref.watch(routeShellProvider);

    //StatefulShellRoute 상태 유지 O
    final router = ref.watch(routeStateFullShellProvider);
    //restoring를 파악 하기 위해(goRouter)
    router.routeInformationProvider.removeListener(changeRoute);
    router.routeInformationProvider.addListener(changeRoute);

    return MaterialApp.router(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: switch (currentTheme) {
        LightTheme() => ThemeData.light(useMaterial3: true),
        DarkTheme() => ThemeData.dark(useMaterial3: true),
      },
      routerConfig: router,
    );
  }
}
