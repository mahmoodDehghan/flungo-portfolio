import 'dart:async';

import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';

class Oauth2Client {
  oauth2.Client? client;
  final String authorizationUrl;
  final String redirectUrl;
  final oauth2.AuthorizationCodeGrant grant;

  Oauth2Client._creatInsatnce({
    required this.authorizationUrl,
    required this.redirectUrl,
    required this.grant,
  });

  factory Oauth2Client({
    required String authorizationEndPoint,
    required String tokenEndPoint,
    required String clientId,
    required String clientSecret,
    required String redirectUrl,
  }) {
    var grant = oauth2.AuthorizationCodeGrant(
      clientId,
      Uri.parse(authorizationEndPoint),
      Uri.parse(tokenEndPoint),
      secret: clientSecret,
    );
    return Oauth2Client._creatInsatnce(
      authorizationUrl:
          grant.getAuthorizationUrl(Uri.parse(redirectUrl)).toString(),
      redirectUrl: redirectUrl,
      grant: grant,
    );
  }

  Future<void> authorize() async {
    if (await canLaunch(authorizationUrl)) {
      launch(authorizationUrl);
    }
  }

  Future<oauth2.Client> compeleteAuthorization(
      Map<String, String> parameters) async {
    client = await grant.handleAuthorizationResponse(parameters);
    return client!;
  }
}
