import 'package:flungo_portfolio/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrentPage with ChangeNotifier {
  CurrentPage({required this.currentPage});
  String currentPage;
  void changePage(String newPage) {
    if (currentPage != newPage) {
      currentPage = newPage;
      notifyListeners();
    }
  }
}

final currentPageProvider = ChangeNotifierProvider<CurrentPage>((ref) {
  return CurrentPage(currentPage: HomePage.routeName);
});
