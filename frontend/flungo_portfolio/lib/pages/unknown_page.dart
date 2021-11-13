import '../routers/route_path.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UnknownPage extends HookConsumerWidget {
  static const String routeName = RoutePath.unknownPath;

  const UnknownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('This is UnknownPage'),
      ),
    );
  }
}
