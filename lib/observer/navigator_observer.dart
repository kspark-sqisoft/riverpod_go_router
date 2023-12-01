import 'package:flutter/material.dart';

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    print('didPush:$route');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    print('didPop:$route');
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    print('didReplace:$newRoute');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    print('didStartUserGesture:$route');
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    print('didStopUserGesture');
    super.didStopUserGesture();
  }
}
