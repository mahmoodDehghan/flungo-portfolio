import 'package:flungo_portfolio/widgets/page_containers/admin_change_password.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../models/const_items.dart';
import '../pages/admin_login_page.dart';
import '../providers/shared_prefrences_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminPage extends HookConsumerWidget {
  static const String routeName = 'admin';
  final isAdminPassChanged = useState(false);

  AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharePrefrences = ref.watch(sharedPrefrencesProvider);
    return Scaffold(
        body: isAdminPassChanged.value
            ? const AdminLoginPage()
            : sharePrefrences.when(
                data: (sharePrefrences) {
                  final bool? isSetupInstalled =
                      sharePrefrences.getBool(ConstItems.adminSetupKey);
                  if (isSetupInstalled == null || isSetupInstalled == false) {
                    return AdminChangePassword(
                      isPassChanged: isAdminPassChanged,
                    );
                  } else {
                    return const AdminLoginPage();
                  }
                },
                loading: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                error: (_, __, ___) {
                  return const Center(child: Text('error occured!'));
                }));
  }
}
