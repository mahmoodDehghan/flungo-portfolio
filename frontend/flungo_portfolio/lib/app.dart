import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../routers/main_router_delegate.dart';
import '../routers/main_router_information_parser.dart';
import '../providers/route_path_provider.dart';

class FlungoPortFolioApp extends HookConsumerWidget {
  const FlungoPortFolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRouteState = ref.read(routeProvider);
    return MaterialApp.router(
      title: 'Flungo Portfolio',
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
