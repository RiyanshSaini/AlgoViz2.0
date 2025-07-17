import 'package:flutter/material.dart';
import 'package:algo_visualizer/providers/sort/insertion_sort_provider.dart';
import 'package:algo_visualizer/ux/widgets/sort/sort_button.dart';
import 'package:algo_visualizer/ux/widgets/sort/sort_speed.dart';

import 'package:provider/provider.dart';

import '../../../providers/sort/bubble_sort_provider.dart';
import '../../widgets/sort/sort_visualizer.dart';

class BubbleSortPage extends StatelessWidget {
  const BubbleSortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BubbleSortProvider(),
      child: Scaffold( // Wrap with Scaffold to ensure full-screen layout
        body: Center(
          child: SafeArea( // Prevents widgets from overlapping system UI
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 64),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Text(
                    'Bubble Sort',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 140),
                // Use Expanded to allow proper resizing
                const Expanded(
                  child: SortVisualizer<BubbleSortProvider>( key: null,),
                  // final horizontalFit = (width / widgetSize).floor(); can divide by zero.
                ),
                const SizedBox(height: 24),
                // Wrap controls in a SizedBox with a limited height
                const SizedBox(
                  height: 180, // Adjust height based on actual need
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min, // Prevents unnecessary expansion
                    children: [
                      SortButton<BubbleSortProvider>(),
                      SizedBox(height: 24),
                      SortSpeed<BubbleSortProvider>(key: null,),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
