import 'package:flungo_portfolio/models/const_items.dart';
import 'package:flungo_portfolio/providers/shared_prefrences_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oauth2/oauth2.dart';

import 'oauth_client_provider.dart';

final adminClientProvider = FutureProvider.family<Client, Map<String, String>?>(
    (ref, parameters) async {
  final pref = await ref.read(sharedPrefrencesProvider.future);
  if (parameters != null) {
    final oauthHandler = ref.read(oAuthClientProvider);
    var client =
        await oauthHandler.state.grant.handleAuthorizationResponse(parameters);
    var remember = pref.getBool(ConstItems.adminLoginedPrefKey);
    if (remember != null && remember == true) {
      pref.setString(ConstItems.adminToken, client.credentials.accessToken);
    }
    return client;
  } else {
    var credentials = Credentials(pref.getString(ConstItems.adminToken)!);
    return Client(credentials);
  }
});
