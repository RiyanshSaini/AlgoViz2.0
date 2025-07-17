
import 'package:flutter/material.dart';

import '../../providers/search/search_provider.dart';
import '../widgets/search/search.dart';
import '../widgets/search/search_indicator.dart';
import '../widgets/search/search_message.dart';
import '../widgets/search/search_visualizer.dart';


class SearchPage<T extends SearchProvider> extends StatelessWidget {
  SearchPage({Key? key, required this.title})
      : assert(title != null),
        super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final GlobalKey parentKey = GlobalKey(debugLabel: title); // Create the parentKey here

    return Stack(
      key: parentKey, // Attach the parentKey to the Stack
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 24),
            // Pass the parentKey to SearchVisualizer
            Expanded(
              child: SearchVisualizer<T>(parentKey: parentKey),
            ),
            const SizedBox(height: 24),
            // Search Controls
            SearchMessage<T>(),
            const SizedBox(height: 24),
            Search<T>(),
            const SizedBox(height: 24),
          ],
        ),
        // Pass the parentKey to SearchIndicator
        // SearchIndicator<T>(
        //   parentKey: parentKey,
        // ),
      ],
    );
  }
}