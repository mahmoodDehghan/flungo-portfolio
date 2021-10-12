import 'package:flungo_portfolio/pages/admin_page.dart';
import 'package:flungo_portfolio/pages/client_page.dart';
import 'package:flungo_portfolio/pages/home_page.dart';
import 'package:flungo_portfolio/routers/main_router_delegate.dart';
import 'package:flungo_portfolio/routers/main_router_information_parser.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FlungoPortFolioApp extends ConsumerWidget {
  FlungoPortFolioApp({Key? key}) : super(key: key);

  final Map<String, Widget> legalRoutes = {
    HomePage.routeName: const HomePage(),
    AdminPage.routeName: const AdminPage(),
    ClientPage.routeName: const ClientPage(),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: MainRouterInformationParser(routes: legalRoutes),
      routerDelegate: MainRouterDelegate(routes: legalRoutes, ref: ref),
    );
  }
}
