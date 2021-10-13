import 'package:flungo_portfolio/providers/route_path_provider.dart';

import '../routers/main_router_delegate.dart';
import '../routers/main_router_information_parser.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FlungoPortFolioApp extends HookConsumerWidget {
  const FlungoPortFolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRouteState = ref.read(routeProvider);
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: MainRouterInformationParser(
        routeState: currentRouteState,
      ),
      routerDelegate: MainRouterDelegate(
        currentRoutePathState: currentRouteState,
      ),
    );
  }
}
