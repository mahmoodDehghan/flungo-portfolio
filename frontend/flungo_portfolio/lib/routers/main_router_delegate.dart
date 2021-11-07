import 'package:flungo_portfolio/providers/route_path_provider.dart';

import './route_path.dart';
import 'package:flutter/material.dart';

class MainRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  RoutePathState currentRoutePathState;

  @override
  RoutePath get currentConfiguration {
    return currentRoutePathState.currentPath;
  }

  MainRouterDelegate({required this.currentRoutePathState}) {
    currentRoutePathState.addListener(notifyListeners);
  }

  @override
  void dispose() {
    currentRoutePathState.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
            key: const ValueKey(RoutePath.homePath),
            child: currentRoutePathState.routes[RoutePath.homePath]!),
        if (currentRoutePathState.currentPath.isUnknown)
          MaterialPage(
              key: const ValueKey(RoutePath.unknownPath),
              child: currentRoutePathState.routes[RoutePath.unknownPath]!),
        if (currentRoutePathState.currentPath.isOtherPage)
          MaterialPage(
            child: currentRoutePathState
                .routes[currentRoutePathState.currentPath.pathName]!,
            arguments: currentRoutePathState.currentPath.uriQueryParameters,
            key: ValueKey(currentRoutePathState.currentPath),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        currentRoutePathState.newRoute = RoutePath.home();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    // if (configuration.uriQueryParameters != null) {
    //   currentRoutePathState.newRoute = configuration;
    // }
    //   if (configuration.isUnknown) {
    //     currentRoutePathState.newRouteWithoutListen = RoutePath.unknown();
    //     return;
    //   }
    //   if (configuration.isHomePage) {
    //     currentRoutePathState.newRouteWithoutListen = RoutePath.home();
    //     return;
    //   }
    //   if (!currentRoutePathState.routes.keys.contains(configuration.pathName)) {
    //     currentRoutePathState.newRouteWithoutListen = RoutePath.unknown();
    //     return;
    //   }
    //   currentRoutePathState.newRouteWithoutListen =
    //       RoutePath.page(configuration.pathName);
  }
}
