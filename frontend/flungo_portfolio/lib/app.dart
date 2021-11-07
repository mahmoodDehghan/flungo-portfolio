import 'package:flungo_portfolio/providers/route_path_provider.dart';
// import 'package:uni_links/uni_links.dart';

import '../routers/main_router_delegate.dart';
import '../routers/main_router_information_parser.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FlungoPortFolioApp extends HookConsumerWidget {
  const FlungoPortFolioApp({Key? key}) : super(key: key);

  // Future<void> initCallbackLink() async {
  //   _sub = uriLinkStream.listen((Uri? uri) {
  //     if (uri!.toString().startsWith('http://my.flungo_portfolio.com/'))
  //       print('uri');
  //     // Parse the link and warn the user, if it is not correct
  //   }, onError: (err) {
  //     // Handle exception by warning the user their action did not succeed
  //   });
  // }

  // void uniLinkInit() async {
  //   try {
  //     final initialUri = await getInitialUri();
  //     print(initialUri.toString());
  //     // Use the uri and warn the user, if it is not correct,
  //     // but keep in mind it could be `null`.
  //   } on FormatException {
  //     // Handle exception by warning the user their action did not succeed
  //     // return?
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // uniLinkInit();
    // final sub = useUniLinkHook(context, (Uri? uri) async {
    //   if (uri != null &&
    //       uri.toString().startsWith('http://my.flungo_portfolio.com/'))
    //     print(uri);
    // });
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
