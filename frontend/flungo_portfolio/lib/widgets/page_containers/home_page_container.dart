import 'package:flungo_portfolio/pages/admin_page.dart';
import 'package:flungo_portfolio/pages/client_page.dart';
import '../../providers/current_page_provider.dart';
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
    return Scaffold(
        body: Row(
      children: [
        getPart('Admin', () {
          ref.watch(currentPageProvider).changePage(AdminPage.routeName);
        }),
        getPart('Client', () {
          ref.watch(currentPageProvider).changePage(ClientPage.routeName);
        }),
      ],
    ));
  }
}
