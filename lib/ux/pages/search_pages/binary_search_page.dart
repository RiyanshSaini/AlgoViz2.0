
import 'package:algo_visualizer/ux/widgets/search/search_message.dart';
import 'package:flutter/material.dart';

import '../../../providers/search/binary_search_provider.dart';
import '../../widgets/search/search.dart';
import '../../widgets/search/search_indicator.dart';
import '../../widgets/search/search_visualizer.dart';

class BinarySearchPage extends StatelessWidget {
  const BinarySearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey parentKey = GlobalKey(); // Create the parentKey here

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const SizedBox(height: 64),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Text(
            'Binary Search',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 24),
        // Pass the parentKey to SearchVisualizer
        Expanded(
          child: SearchVisualizer<BinarySearchProvider>(parentKey: parentKey),
        ),
        const SizedBox(height: 24),
        // Search Controls for Binary Search
        const SearchMessage<BinarySearchProvider>(),
        const Search<BinarySearchProvider>(),
        const SizedBox(height: 24),
        // SearchIndicator(parentKey: parentKey),
      ],
    );
  }
}
