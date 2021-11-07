import 'package:flungo_portfolio/providers/route_path_provider.dart';
import 'package:flungo_portfolio/routers/route_path.dart';

import '../../pages/admin_page.dart';
import '../../pages/client_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePageContainer extends HookConsumerWidget {
  const HomePageContainer({Key? key}) : super(key: key);

  Widget getButton(String _label, Function()? _onPressed) {
    return ElevatedButton(
      onPressed: _onPressed,
      child: Text(_label),
    );
  }

  Widget getPart(String _label, Function()? _onPressed) {
    return Expanded(
      flex: 1,
      child: Center(
        child: getButton(_label, _onPressed),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routeProvider);
    return Scaffold(
      body: Row(
        children: [
          getPart('Admin', () {
            router.newRoute = RoutePath.page(AdminPage.routeName, null);
          }),
          getPart('Client', () {
            router.newRoute = RoutePath.page(ClientPage.routeName, null);
          }),
        ],
      ),
    );
  }
}
