import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/tree_provider.dart';
import '../../../providers/tree_provider2.dart';

class TraversalButton<T extends TreeProvider> extends StatelessWidget {
  const TraversalButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<T>(context);
    return ElevatedButton(
      onPressed: provider.isTraversing
          ? null
          : () {
        provider.startTraversal(); // ✅ Now calling the function
        print("Start Traversal Clicked");
      },
      child: const Text("Start DFS"),
    );
  }
}
