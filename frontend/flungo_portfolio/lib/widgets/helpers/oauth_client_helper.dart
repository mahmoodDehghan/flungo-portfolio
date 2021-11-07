import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class CustomOAuthClient extends OAuth2Client {
  final String clientId;
  final String clientSecret;
  AccessTokenResponse? authToken;
  late final OAuth2Helper oAuthHelper;
  final String mainUrl;
  static const String authUrl = '/o/authorize/';
  static const String tokUrl = '/o/token/';
  static const String revokUrl = '/o/revoke_token/';

  CustomOAuthClient({
    required String redirectUri,
    required String customUriScheme,
    required this.mainUrl,
    required this.clientId,
    required this.clientSecret,
  }) : super(
          authorizeUrl: mainUrl + authUrl,
          tokenUrl: mainUrl + tokUrl,
          redirectUri: redirectUri,
          customUriScheme: customUriScheme,
          refreshUrl: mainUrl + tokUrl,
          revokeUrl: mainUrl + revokUrl,
        ) {
    oAuthHelper = OAuth2Helper(
      this,
      grantType: OAuth2Helper.AUTHORIZATION_CODE,
      clientSecret: clientSecret,
      clientId: clientId,
      scopes: ['read', 'write'],
    );
  }

  Future<AccessTokenResponse?> getAuthToken() async {
    authToken = await oAuthHelper.getToken();
    return authToken;
  }

  Future<AccessTokenResponse?> getRefreshToken() async {
    authToken = await oAuthHelper.refreshToken(authToken!.refreshToken!);
    return authToken;
  }
}
