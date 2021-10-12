import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientPage extends HookConsumerWidget {
  static const String routeName = 'client';

  const ClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('This is ClientPage'),
      ),
    );
  }
}
