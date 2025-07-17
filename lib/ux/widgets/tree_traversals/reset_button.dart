import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/dummy_tree_provider.dart';
import '../../../providers/tree_provider.dart';
import '../tree_traversals/animated_tree_vis.dart';

class ResetButton extends StatelessWidget {
  final GlobalKey<AnimatedTreeVisualizerState> treeKey;

  const ResetButton({super.key, required this.treeKey});

  @override
  Widget build(BuildContext context) {
    return Consumer<DummyTreeProvider>(
      builder: (context, provider, child) {
        return ElevatedButton(
          onPressed: provider.isTraversing
              ? null
              : () {
            treeKey.currentState?.resetTree(); // ✅ Calls resetTree
            print("Reset Clicked");
          },
          child: const Text("Reset"),
        );
      },
    );
  }
}
