import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:oauth2/oauth2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/helpers/platform_helper.dart';
import '../models/const_items.dart';
import '../widgets/page_containers/admin_login_page.dart';
import '../providers/shared_prefrences_provider.dart';
import '../../widgets/page_containers/admin_change_password.dart';
import '../widgets/page_containers/admin_page_container.dart';
import '../providers/oauth_client_provider.dart';

class AdminPage extends HookConsumerWidget {
  static const String routeName = 'admin';
  final isAdminPassChanged = useState(false);
  final isAdminLogined = useState(false);
  final isOnAuthorization = useState(false);

  AdminPage({Key? key}) : super(key: key);

  Widget compeleteLoginWidget(
      BuildContext context, WidgetRef ref, Map<String, String> uriParams) {
    final oauthHandler = ref.watch(oAuthClientProvider);
    final clientFuture = Future<Client>(() async {
      var client = await oauthHandler.state.compeleteAuthorization(uriParams);

      final pref = await ref.read(sharedPrefrencesProvider.future);
      var remember = pref.getBool(ConstItems.adminLoginedPrefKey);
      if (remember != null && remember == true) {
        pref.setString(ConstItems.adminToken, client.credentials.accessToken);
      }
      return client;
    });
    return Scaffold(
      body: FutureBuilder(
        key: const ValueKey('future'),
        future: clientFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return const AdminPageContainer();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: Text('Error Occurred!'),
              );
            }
          }
        },
      ),
    );
  }

  Widget adminPageHandler(SharedPreferences sharePrefrences) {
    final bool? isSetupInstalled =
        sharePrefrences.getBool(ConstItems.adminSetupKey);
    final bool? isAdminLogged =
        sharePrefrences.getBool(ConstItems.adminLoginedPrefKey);
    if (isSetupInstalled == null || isSetupInstalled == false) {
      return AdminChangePassword(
        isPassChanged: isAdminPassChanged,
      );
    } else if (isAdminLogged == null ||
        isAdminLogged == false ||
        sharePrefrences.getString(ConstItems.adminToken) == null) {
      return AdminLoginContainer(
        adminLoginState: isAdminLogined,
      );
    } else {
      return const AdminPageContainer();
    }
  }

  bool hasParams(Map<String, String>? uriParams) {
    return uriParams != null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharePrefrences = ref.watch(sharedPrefrencesProvider);
    final uriParams =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    if (PlatformHelper.isMobile && hasParams(uriParams)) {
      return compeleteLoginWidget(context, ref, uriParams!);
    }
    return Scaffold(
      body: isAdminLogined.value
          ? const AdminPageContainer()
          : isAdminPassChanged.value
              ? AdminLoginContainer(
                  adminLoginState: isAdminLogined,
                )
              : sharePrefrences.when(
                  data: adminPageHandler,
                  loading: (_) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (_, __, ___) {
                    return const Center(child: Text('error occured!'));
                  }),
    );
  }
}
