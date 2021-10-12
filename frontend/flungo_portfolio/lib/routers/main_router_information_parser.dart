import 'package:flungo_portfolio/routers/route_path.dart';
import 'package:flutter/material.dart';

class MainRouterInformationParser extends RouteInformationParser<RoutePath> {
  Map<String, Widget> routes;

  MainRouterInformationParser({required this.routes}) : super();

  @override
  Future<RoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return RoutePath.home();
    } else {
      var routeName = uri.pathSegments[0];
      if (routeName == '') {
        routeName = RoutePath.homePath;
      }

      if (routes.keys.contains(routeName)) {
        return RoutePath.page(routeName);
      }
    }

    return RoutePath.unknown();
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
