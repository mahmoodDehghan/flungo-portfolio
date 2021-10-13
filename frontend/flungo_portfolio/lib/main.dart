import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    const ProviderScope(
      child: FlungoPortFolioApp(),
    ),
  );
}
