import 'package:flungo_portfolio/providers/current_page_provider.dart';
import 'package:flungo_portfolio/routers/route_path.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  bool _show404 = false;
  final WidgetRef ref;
//  String _currentRoutePath = RoutePath.homePath;
  Map<String, Widget> routes;

  CurrentPage getCurrentPage() {
    return ref.watch(currentPageProvider);
  }

  MainRouterDelegate({required this.routes, required this.ref})
      : navigatorKey = GlobalKey<NavigatorState>();

  @override
  RoutePath get currentConfiguration {
    final _currentRoutePath = getCurrentPage().currentPage;
    if (_show404) return RoutePath.unknown();
    return _currentRoutePath == '/'
        ? RoutePath.home()
        : RoutePath.page(_currentRoutePath);
  }

  @override
  Widget build(BuildContext context) {
    final _currentRoutePath = getCurrentPage().currentPage;
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
            key: const ValueKey(RoutePath.homePath),
            child: routes[RoutePath.homePath]!),
        if (_show404)
          MaterialPage(
              key: const ValueKey(RoutePath.unknownPath),
              child: routes[RoutePath.unknownPath]!),
        if (_currentRoutePath != RoutePath.homePath)
          MaterialPage(
              child: routes[_currentRoutePath]!,
              key: ValueKey(_currentRoutePath)),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        getCurrentPage().changePage(RoutePath.homePath);
        _show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    if (configuration.isUnknown) {
      getCurrentPage().changePage(RoutePath.unknownPath);
      _show404 = true;
      return;
    }
    if (configuration.isHomePage) {
      getCurrentPage().changePage(RoutePath.homePath);
      _show404 = false;
      return;
    }
    if (!routes.keys.contains(configuration.pathName)) {
      _show404 = true;
      return;
    }
    getCurrentPage().changePage(configuration.pathName);
    _show404 = false;
  }
}
