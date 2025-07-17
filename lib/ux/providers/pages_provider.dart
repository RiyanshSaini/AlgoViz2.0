

import 'package:flutter/cupertino.dart';
import '../../providers/search/binary_search_provider.dart';
import '../../providers/search/linear_search_provider.dart';
import '../pages/search_page.dart';

class PagesProvider extends ChangeNotifier {
  String categoryKey = 'Search';

  final _searchPages = [
    SearchPage<LinearSearchProvider>(title: 'Linear Search',),
    SearchPage<BinarySearchProvider>(title:'Binary Search',)
  ];

  void changeKey(String key) {
    categoryKey = key;
    notifyListeners();
  }

  List<StatelessWidget> get pages {
    // if (categoryKey == 'Search') {
    //   return
    // }
    switch (categoryKey) {
      case 'Search':
        return _searchPages;
        break;
      default:
        return _searchPages;
        break;
    }
  }
}
