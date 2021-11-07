import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/admin_page.dart';
import '../pages/client_page.dart';
import '../pages/home_page.dart';
import '../pages/unknown_page.dart';
import '../routers/route_path.dart';

class RoutePathState extends ChangeNotifier {
  RoutePath _currentPath = RoutePath.home();
  final Map<String, Widget> routes;

  RoutePathState({required this.routes});

  set newRoute(RoutePath newRoute) {
    if (newRoute.pathName != _currentPath.pathName ||
        newRoute.uriQueryParameters != null) {
      if (routes.containsKey(newRoute.pathName)) {
        _currentPath = newRoute;
      } else {
        _currentPath = RoutePath.unknown();
      }
      notifyListeners();
    }
  }

  set newRouteWithoutListen(RoutePath newRoute) {
    if (newRoute.pathName != _currentPath.pathName) {
      if (routes.containsKey(newRoute.pathName)) {
        _currentPath = newRoute;
      } else {
        _currentPath = RoutePath.unknown();
      }
    }
  }

  RoutePath get currentPath {
    return _currentPath;
  }
}

final Map<String, Widget> _legalRoutes = {
  HomePage.routeName: const HomePage(),
  AdminPage.routeName: AdminPage(),
  ClientPage.routeName: const ClientPage(),
  UnknownPage.routeName: const UnknownPage(),
};

final routeProvider = ChangeNotifierProvider<RoutePathState>((ref) {
  return RoutePathState(routes: _legalRoutes);
});
