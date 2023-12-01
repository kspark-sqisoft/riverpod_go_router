import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_go_router/components/page_not_found.dart';
import 'package:riverpod_go_router/components/scaffold_with_navbar_shell.dart';
import 'package:riverpod_go_router/observer/navigator_observer.dart';
import 'package:riverpod_go_router/pages/medias/medias_page.dart';
import 'package:riverpod_go_router/pages/weather/search_page.dart';
import 'package:riverpod_go_router/pages/weather/temp_settings_page.dart';
import 'package:riverpod_go_router/pages/weather/weather_page.dart';
import 'package:riverpod_go_router/pages/products/product_page.dart';
import 'package:riverpod_go_router/pages/products/products_page.dart';
import 'package:riverpod_go_router/pages/signin/signin_page.dart';
import 'package:riverpod_go_router/pages/signup/signup_page.dart';
import 'package:riverpod_go_router/pages/todos/todos_page.dart';
import 'package:riverpod_go_router/providers/auth_state_provider.dart';
import 'package:riverpod_go_router/router/route_names.dart';
import 'package:riverpod_go_router/router/router_state_full_shell_provider.dart';

part 'router_shell_provider.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter routeShell(RouteShellRef ref) {
  print('routeShellProvider created');
  ref.onDispose(() {
    print('routeShellProvider onDispose');
  });
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    observers: [MyNavigatorObserver()],
    initialLocation: '/weather',
    errorBuilder: (BuildContext context, GoRouterState state) {
      return PageNotFound(
        errMsg: state.error.toString(),
      );
    },
    redirect: (BuildContext context, GoRouterState state) {
      final authenticated = authState;
      final tryingSignin = state.matchedLocation == '/signin';
      final tryingSignup = state.matchedLocation == '/signup';
      final authenticating = tryingSignin || tryingSignup;

      /**
       * 로그아웃 상태
       *  signin, signup 페이지이면 => null
       *  다른 페이지면 => signin
       */
      if (!authenticated) return authenticating ? null : '/signin';

      /**
       * 로그인 상태
       *  signin, signup 페이지이면 => posts
       */
      if (authenticating) return '/weather';

      return null;
    },
    routes: [
      GoRoute(
        path: '/signin',
        name: RouteNames.signin,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(child: SignInPage());
        },
      ),
      GoRoute(
        path: '/signup',
        name: RouteNames.signup,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(child: SignUpPage());
        },
      ),
      ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return ScaffoldWithNavbarShell(
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: '/weather',
              name: RouteNames.weather,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(child: WeatherPage());
              },
              routes: [
                GoRoute(
                  path: 'weathersearch',
                  name: RouteNames.weathersearch,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return const NoTransitionPage(child: SearchPage());
                  },
                ),
                GoRoute(
                  path: 'weathertempsettings',
                  name: RouteNames.weathertempsettings,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return const NoTransitionPage(child: TempSettingsPage());
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/medias',
              name: RouteNames.medias,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(child: MediasPage());
              },
            ),
            GoRoute(
              path: '/products',
              name: RouteNames.products,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(
                  child: ProductsPage(),
                );
              },
              routes: [
                GoRoute(
                  path: 'detail/:id',
                  name: RouteNames.product,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    final id = state.pathParameters['id']!;
                    return NoTransitionPage(
                        child: ProductPage(
                      id: int.parse(id),
                    ));
                  },
                )
              ],
            ),
            GoRoute(
              path: '/todos',
              name: RouteNames.todos,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const NoTransitionPage(child: TodosPage());
              },
            ),
          ]),
    ],
  );
}
