import '../routers/route_path.dart';
import '../widgets/page_containers/home_page_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  static const String routeName = RoutePath.homePath;

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const HomePageContainer();
  }
}
