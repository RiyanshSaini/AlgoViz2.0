import 'package:flutter/material.dart';

import '../../../providers/sort_provider.dart';
import 'package:provider/provider.dart';

class SortSpeed<T extends SortProvider> extends StatelessWidget {
  const SortSpeed({required super.key});

  @override
  Widget build(BuildContext context) {
    // return Selector<BubbleSortProvider, double>(
    //     selector: (_, bubble) => bubble.sortSpeed,
    //     builder: (_, value, child) {
    //       return Slider(
    //         value: value,
    //         onChanged: (val) {
    //           // value = val;
    //           Provider.of<BubbleSortProvider>(context, listen: false)
    //               .sortSpeed = val;
    //         },
    //       );
    //     });
    return Column(
      children: <Widget>[
        Text('Sort Speed', style: Theme.of(context).textTheme.bodySmall),
        Selector<T, double>(
          selector: (context, provider) => provider.executionSpeed,
          builder: (context, executionSpeed, child) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Slider(
                value: executionSpeed,
                onChanged: (value) => Provider.of<T>(context, listen: false)
                    .executionSpeed = value,
              ),
            );
          },
        ),
      ],
    );
  }
}