import 'package:flutter/foundation.dart';

import '../models/const_items.dart';
import '../widgets/helpers/oauth2_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Oauth2Client getOAuthHandler() {
  if (TargetPlatform.android == defaultTargetPlatform) {
    return Oauth2Client(
      authorizationEndPoint: ConstItems.androidBaseUrl + '/o/authorize/',
      clientId: 'IwZ3xncsbEyez5DnlpwUgnajMm97WyKhuVMBehcc',
      clientSecret:
          'rPOtZuRGMoKyiFSScfyr9A025mH2LDUzNhJEwfCVoDR1mOHlLC0bBLxQabGZVLlkanYoc9ZPhAhLOmu6rBLm1rOwEXI5wMXGyQElaUqrHLv9aY6ZPBIAsQ40nFmSqhIG',
      redirectUrl: 'http://my.flungo_portfolio.com/',
      tokenEndPoint: ConstItems.androidBaseUrl + '/o/token/',
    );
  } else if (kIsWeb) {
    return Oauth2Client(
      authorizationEndPoint: ConstItems.baseUrl + '/o/authorize/',
      clientId: ConstItems.oClientID,
      clientSecret: ConstItems.oClientSecret,
      redirectUrl: ConstItems.oRedirectUrl,
      tokenEndPoint: ConstItems.baseUrl + '/o/token/',
    );
  }
  return Oauth2Client(
    authorizationEndPoint: ConstItems.baseUrl + '/o/authorize/',
    tokenEndPoint: ConstItems.baseUrl + '/o/token/',
    clientId: ConstItems.winClientID,
    clientSecret: ConstItems.winClientSecret,
    redirectUrl: ConstItems.winRedirectUrl,
  );
}

final oAuthClientProvider = StateProvider<Oauth2Client>((ref) {
  return getOAuthHandler();
});
