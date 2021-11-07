import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:oauth2/oauth2.dart';

import '../models/const_items.dart';
import '../widgets/page_containers/admin_login_page.dart';
import '../providers/shared_prefrences_provider.dart';
import '../providers/token_provider.dart';
import '../../widgets/page_containers/admin_change_password.dart';
import '../widgets/page_containers/admin_page_container.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminPage extends HookConsumerWidget {
  static const String routeName = 'admin';
  final isAdminPassChanged = useState(false);
  final isAdminLogined = useState(false);
  //final isRedirected = useState(false);

  AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharePrefrences = ref.watch(sharedPrefrencesProvider);
    final uriParams =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    final hasParams = uriParams != null;
    if (hasParams) {
      final adminApiClient = ref.watch(adminClientProvider(uriParams));
      return Scaffold(
        body: adminApiClient.when<Widget>(
          data: (client) {
            if (client.credentials.accessToken.isNotEmpty) {
              return const AdminPageContainer();
            } else {
              return const Center(
                child: Text('Error in login'),
              );
            }
          },
          error: (err, stack, ___) {
            return Center(
              child: Text(err.toString()),
            );
          },
          loading: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: isAdminLogined.value
            ? const AdminPageContainer()
            : isAdminPassChanged.value
                ? AdminLoginContainer(
                    adminLoginState: isAdminLogined,
                    //redirectState: isRedirected,
                  )
                : sharePrefrences.when(
                    data: (sharePrefrences) {
                      final bool? isSetupInstalled =
                          sharePrefrences.getBool(ConstItems.adminSetupKey);
                      final bool? isAdminLogged = sharePrefrences
                          .getBool(ConstItems.adminLoginedPrefKey);
                      if (isSetupInstalled == null ||
                          isSetupInstalled == false) {
                        return AdminChangePassword(
                          isPassChanged: isAdminPassChanged,
                        );
                      } else if (isAdminLogged == null ||
                          isAdminLogged == false ||
                          sharePrefrences.getString(ConstItems.adminToken) ==
                              null) {
                        return AdminLoginContainer(
                          adminLoginState: isAdminLogined,
                          //redirectState: isRedirected,
                        );
                      } else {
                        return const AdminPageContainer();
                      }
                    },
                    loading: (_) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                    error: (_, __, ___) {
                      return const Center(child: Text('error occured!'));
                    }),
      );
    }
  }
}
