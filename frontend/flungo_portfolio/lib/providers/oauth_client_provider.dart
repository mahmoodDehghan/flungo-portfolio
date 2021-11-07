import 'dart:io';

import 'package:flungo_portfolio/models/const_items.dart';
import '../widgets/helpers/oauth2_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final oAuthClientProvider = StateProvider<Oauth2Client>((ref) {
  if (Platform.isAndroid) {
    return Oauth2Client(
      authorizationEndPoint: ConstItems.androidBaseUrl + '/o/authorize/',
      clientId: 'IwZ3xncsbEyez5DnlpwUgnajMm97WyKhuVMBehcc',
      clientSecret:
          'rPOtZuRGMoKyiFSScfyr9A025mH2LDUzNhJEwfCVoDR1mOHlLC0bBLxQabGZVLlkanYoc9ZPhAhLOmu6rBLm1rOwEXI5wMXGyQElaUqrHLv9aY6ZPBIAsQ40nFmSqhIG',
      redirectUrl: 'http://my.flungo_portfolio.com/',
      tokenEndPoint: ConstItems.androidBaseUrl + '/o/token/',
    );
  }
  return Oauth2Client(
    authorizationEndPoint: ConstItems.baseUrl + '/o/authorize/',
    clientId: ConstItems.oClientID,
    clientSecret: ConstItems.oClientSecret,
    redirectUrl: 'http://localhost:8001/',
    tokenEndPoint: ConstItems.baseUrl + '/o/token/',
  );
});
