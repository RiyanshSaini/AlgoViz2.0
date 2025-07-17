import 'package:algo_visualizer/ux/widgets/search/search_message.dart';
import 'package:flutter/material.dart';

import '../../../providers/search/linear_search_provider.dart';
import '../../widgets/search/search.dart';
import '../../widgets/search/search_indicator.dart';
import '../../widgets/search/search_visualizer.dart';

class LinearSearchPage extends StatelessWidget {
  const LinearSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey parentKey = GlobalKey(); // Create the parentKey here

    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(height: 64),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(
                'Linear Search',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 24),
            // Pass the parentKey to SearchVisualizer
            Expanded(
              child: SearchVisualizer<LinearSearchProvider>(parentKey: parentKey),
            ),
            const SizedBox(height: 24),
            // Search Controls for Linear Search
            const SearchMessage<LinearSearchProvider>(),
            const Search<LinearSearchProvider>(),
            const SizedBox(height: 24),
          ],
        ),
        // Pass the parentKey to SearchIndicator
        // SearchIndicator<LinearSearchProvider>(
        //   parentKey: parentKey,
        // ),
      ],
    );
  }
}