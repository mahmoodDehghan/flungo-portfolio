import 'dart:io' show Platform;

import 'package:flungo_portfolio/hooks/unilink_hook.dart';
import 'package:flungo_portfolio/providers/oauth_client_provider.dart';
import 'package:flungo_portfolio/widgets/helpers/oauth2_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../helpers/oauth_client_helper.dart';
import '../../models/const_items.dart';
import '../../providers/shared_prefrences_provider.dart';

class AdminLoginContainer extends HookConsumerWidget {
  final remember = useState(true);
  final ValueNotifier adminLoginState;
  //final ValueNotifier redirectState;

  AdminLoginContainer({
    Key? key,
    required this.adminLoginState,
    // required this.redirectState,
  }) : super(key: key);

  void login(WidgetRef ref) async {
    final pref = await ref.read(sharedPrefrencesProvider.future);
    pref.setBool(ConstItems.adminLoginedPrefKey, remember.value);
    var client = CustomOAuthClient(
      redirectUri: 'http://localhost:8001/',
      customUriScheme: 'flungo_portfolio:/',
      mainUrl: ConstItems.baseUrl,
      clientId: ConstItems.oClientID,
      clientSecret: ConstItems.oClientSecret,
    );
    var token = await client.getAuthToken();
    if (token != null && token.accessToken != null) {
      pref.setString(ConstItems.adminToken, token.accessToken!);
      adminLoginState.value = true;
    }
  }

  void androidLogin(BuildContext ctx, WidgetRef ref) async {
    final pref = await ref.read(sharedPrefrencesProvider.future);
    pref.setBool(ConstItems.adminLoginedPrefKey, remember.value);
    final clProvider = ref.read(oAuthClientProvider);
    // var client = Oauth2Client(
    //   authorizationEndPoint: ConstItems.androidBaseUrl + '/o/authorize/',
    //   clientId: 'IwZ3xncsbEyez5DnlpwUgnajMm97WyKhuVMBehcc',
    //   clientSecret:
    //       'rPOtZuRGMoKyiFSScfyr9A025mH2LDUzNhJEwfCVoDR1mOHlLC0bBLxQabGZVLlkanYoc9ZPhAhLOmu6rBLm1rOwEXI5wMXGyQElaUqrHLv9aY6ZPBIAsQ40nFmSqhIG',
    //   redirectUrl: 'http://my.flungo_portfolio.com/',
    //   tokenEndPoint: ConstItems.androidBaseUrl + '/o/token/',
    // );

    await clProvider.state.authorize();
    // var client = CustomOAuthClient(
    //   redirectUri: 'http://my.flungo_portfolio.com/',
    //   customUriScheme: '',
    //   mainUrl: ConstItems.androidBaseUrl,
    //   clientId: 'IwZ3xncsbEyez5DnlpwUgnajMm97WyKhuVMBehcc',
    //   clientSecret:
    //       'rPOtZuRGMoKyiFSScfyr9A025mH2LDUzNhJEwfCVoDR1mOHlLC0bBLxQabGZVLlkanYoc9ZPhAhLOmu6rBLm1rOwEXI5wMXGyQElaUqrHLv9aY6ZPBIAsQ40nFmSqhIG',
    // );
    // var token = await client.getAuthToken();
    // print(token!.accessToken);
    // if (token != null && token.accessToken != null) {
    //   final pref = await ref.read(sharedPrefrencesProvider.future);
    //   pref.setBool(ConstItems.adminLoginedPrefKey, remember.value);
    //   pref.setString(ConstItems.adminToken, token.accessToken!);
    //   adminLoginState.value = true;
    // }
  }

  void rememberChanged(bool? newValue) {
    if (newValue == null) {
      remember.value = false;
    } else {
      remember.value = newValue;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Platform.isAndroid ? androidLogin(context, ref) : login(ref),
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
