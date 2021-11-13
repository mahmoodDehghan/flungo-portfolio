import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/oauth_client_provider.dart';
import '../../widgets/helpers/platform_helper.dart';
import '../../widgets/helpers/oauth2_client.dart';
import '../../widgets/helpers/web_oauth_client_helper.dart';
import '../../models/const_items.dart';
import '../../providers/shared_prefrences_provider.dart';

class AdminLoginContainer extends HookConsumerWidget {
  final remember = useState(true);
  final ValueNotifier adminLoginState;

  AdminLoginContainer({
    Key? key,
    required this.adminLoginState,
  }) : super(key: key);

  void setAdminLoginnedTrue() {
    adminLoginState.value = true;
  }

  void webLogin(WidgetRef ref, SharedPreferences pref) async {
    var client = WebCustomOAuthClient(
      redirectUri: 'http://localhost:8001/',
      customUriScheme: 'flungo_portfolio:/',
      mainUrl: ConstItems.baseUrl,
      clientId: ConstItems.oClientID,
      clientSecret: ConstItems.oClientSecret,
    );
    var token = await client.getAuthToken();
    if (token != null && token.accessToken != null) {
      if (remember.value) {
        pref.setString(ConstItems.adminToken, token.accessToken!);
      }
      setAdminLoginnedTrue();
    }
  }

  void winLogin(BuildContext ctx, WidgetRef ref, Oauth2Client client,
      SharedPreferences pref) async {
    launchUrl(client);
    await client.listenAndCompeleteAuthorization();
    if (remember.value) {
      pref.setString(
          ConstItems.adminToken, client.client!.credentials.accessToken);
    }
    setAdminLoginnedTrue();
  }

  void mobileLogin(Oauth2Client client) async {
    launchUrl(client);
  }

  void launchUrl(Oauth2Client client) async {
    client.authorize();
    String url = client.authorizationUrl!.toString();
    if (await canLaunch(url)) {
      launch(url);
    }
  }

  void login(BuildContext ctx, WidgetRef ref) async {
    final pref = await ref.read(sharedPrefrencesProvider.future);
    pref.setBool(ConstItems.adminLoginedPrefKey, remember.value);
    final oauthClient = ref.watch(oAuthClientProvider);

    if (PlatformHelper.isWeb) {
      webLogin(ref, pref);
    } else {
      if (PlatformHelper.isWindows) {
        winLogin(ctx, ref, oauthClient.state, pref);
      } else if (PlatformHelper.isMobile) {
        mobileLogin(oauthClient.state);
      }
    }
  }

  void rememberChanged(bool? newValue) {
    if (newValue == null) {
      remember.value = false;
    } else {
      remember.value = newValue;
    }
  }

  Widget getButton(BuildContext context, FollowLink? followLink) {
    return ElevatedButton(
      onPressed: followLink,
      child: const Text('login'),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => login(context, ref),
              child: const Text('login'),
            ),
            CheckboxListTile(
              title: const Text('remember me'),
              value: remember.value,
              onChanged: rememberChanged,
            )
          ],
        ),
      ),
    );
  }
}
