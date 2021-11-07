import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminPageContainer extends HookConsumerWidget {
  const AdminPageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('This is Admin Page With Loggin Token'),
    );
  }
}
