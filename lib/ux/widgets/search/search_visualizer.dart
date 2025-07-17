
import 'package:algo_visualizer/ux/widgets/search/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/search_model.dart';
import '../../../providers/search/search_provider.dart';

class SearchVisualizer<T extends SearchProvider> extends StatelessWidget {
  const SearchVisualizer({super.key, required this.parentKey});

  final GlobalKey parentKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        key: parentKey, // Attach the parentKey here
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity, // Make sure it takes full width
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (var number in Provider.of<T>(context).numbers)
                  SizedBox(
                    width: constraints.maxWidth / Provider.of<T>(context).numbers.length,
                    child: SearchWidget(number: number),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
