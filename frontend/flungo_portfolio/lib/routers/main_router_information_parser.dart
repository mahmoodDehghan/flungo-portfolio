import 'package:flutter/material.dart';

import '../widgets/helpers/platform_helper.dart';
import '../pages/admin_page.dart';
import '../providers/route_path_provider.dart';
import './route_path.dart';

class MainRouterInformationParser extends RouteInformationParser<RoutePath> {
  RoutePathState routeState;

  MainRouterInformationParser({required this.routeState}) : super();

  @override
  Future<RoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    RoutePath route = RoutePath.home();
    if (uri.pathSegments.isEmpty) {
      if (PlatformHelper.isMobile && uri.hasQuery) {
        route = RoutePath.page(AdminPage.routeName, uri.queryParameters);
        routeState.newRoute = route;
        return route;
      }
    } else {
      var routeName = uri.pathSegments[0];
      if (routeState.routes.keys.contains(routeName)) {
        route = RoutePath.page(routeName, uri.queryParameters);
      } else {
        route = RoutePath.unknown();
      }
    }
    routeState.newRouteWithoutListen = route;
    return route;
  }

  @override
  RouteInformation? restoreRouteInformation(RoutePath configuration) {
    if (configuration.isUnknown) {
      return const RouteInformation(location: '/${RoutePath.unknownPath}');
    }
    if (configuration.isHomePage) {
      return const RouteInformation(location: RoutePath.homePath);
    }
    if (configuration.isOtherPage) {
      return RouteInformation(location: '/${configuration.pathName}');
    }
    return null;
  }
}
