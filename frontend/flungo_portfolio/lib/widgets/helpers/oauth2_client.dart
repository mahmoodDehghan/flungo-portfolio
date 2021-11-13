import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;

class Oauth2Client {
  oauth2.Client? client;
  Uri? authorizationUrl;
  final String redirectUrl;
  final oauth2.AuthorizationCodeGrant grant;
  HttpServer? _redirectServer;

  Oauth2Client._creatInsatnce({
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
    var mGrant = oauth2.AuthorizationCodeGrant(
      clientId,
      Uri.parse(authorizationEndPoint),
      Uri.parse(tokenEndPoint),
      secret: clientSecret,
    );
    if (!kIsWeb && TargetPlatform.windows == defaultTargetPlatform) {
      mGrant = oauth2.AuthorizationCodeGrant(
        clientId,
        Uri.parse(authorizationEndPoint),
        Uri.parse(tokenEndPoint),
        secret: clientSecret,
        httpClient: _JsonAcceptingHttpClient(),
      );
    }

    return Oauth2Client._creatInsatnce(
      redirectUrl: redirectUrl,
      grant: mGrant,
    );
  }

  Uri? authorize() {
    authorizationUrl ??= grant.getAuthorizationUrl(Uri.parse(redirectUrl));
    return authorizationUrl;
  }

  Future<oauth2.Client> listenAndCompeleteAuthorization() async {
    await _redirectServer?.close();
    _redirectServer = await HttpServer.bind('localhost', 10);
    var request = await _redirectServer!.first;
    var params = request.uri.queryParameters;
    request.response.statusCode = 200;
    request.response.headers.set('content-type', 'text/plain');
    request.response.writeln('Authenticated! You can close this tab.');
    await request.response.close();
    await _redirectServer!.close();
    _redirectServer = null;
    return await compeleteAuthorization(params);
  }

  Future<oauth2.Client> compeleteAuthorization(
      Map<String, String> parameters) async {
    client = await grant.handleAuthorizationResponse(parameters);
    return client!;
  }
}

class _JsonAcceptingHttpClient extends http.BaseClient {
  final _httpClient = http.Client();
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Accept'] = 'application/json';
    return _httpClient.send(request);
  }
}
