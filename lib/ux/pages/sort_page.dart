import 'package:flutter/material.dart';

import '../../providers/sort_provider.dart';
import '../widgets/sort/sort_button.dart';
import '../widgets/sort/sort_speed.dart';
import '../widgets/sort/sort_visualizer.dart';

class SortPage<T extends SortProvider> extends StatelessWidget {
  const SortPage({required Key key, required this.title, this.blockSize = 100})
      : assert(title != null),
        super(key: key);

  final String title;
  final double blockSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
            ),
            //Cannot be const
            Expanded(
              child: Container(
                width: constraints.maxWidth,
                child: Center(
                  child: SortVisualizer<T>(
                    // blockSize: blockSize,
                    // width: constraints.maxWidth, key: null,
                  ),
                ),
              ),
            ),
            SortSpeed<T>(key: null,),
            SortButton<T>(key: null,),
          ],
        ),
      );
    });
    // return
  }
}