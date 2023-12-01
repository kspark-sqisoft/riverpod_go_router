import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_go_router/components/page_not_found.dart';
import 'package:riverpod_go_router/components/scffold_with_navbar_state_full_shell.dart';
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

part 'router_state_full_shell_provider.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
@riverpod
GoRouter routeStateFullShell(RouteStateFullShellRef ref) {
  print('routeStateFullShellProvider created');
  ref.onDispose(() {
    print('routeStateFullShellProvider onDispose');
  });
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/weather',
    observers: [MyNavigatorObserver()],
    errorBuilder: (BuildContext context, GoRouterState state) {
      return PageNotFound(
        errMsg: state.error.toString(),
      );
    },
    //라우트가 변하거나, authStateProvider 가 변할 경우
    redirect: (BuildContext context, GoRouterState state) {
      final authenticated = authState; //인증 여부
      final tryingSignin = state.matchedLocation == '/signin'; //signin을 하려고 한다
      final tryingSignup = state.matchedLocation == '/signup'; //signup을 하려고 한다.
      final authenticating = tryingSignin || tryingSignup; //둘중 하나라도 true면 true

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

      return null; //null이면 리다이렉트 하지 않는다.
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
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell statefulNavigationShell) {
          return ScaffoldWithNavBarStateFullShell(
              statefulNavigationShell: statefulNavigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/weather',
                name: RouteNames.weather,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  print('weather pageBuilder');
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
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/medias',
                name: RouteNames.medias,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  print('medias pageBuilder');
                  return const NoTransitionPage(child: MediasPage());
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/products',
                name: RouteNames.products,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  print('products pageBuilder');
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
                          child: ProductPage(id: int.parse(id)));
                    },
                  )
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/todos',
                name: RouteNames.todos,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  print('todos pageBuilder');
                  return const NoTransitionPage(child: TodosPage());
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
