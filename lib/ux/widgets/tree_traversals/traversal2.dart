import 'package:algo_visualizer/providers/trees_traversal/bfs_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/tree_provider.dart';
import '../../../providers/tree_provider2.dart';

// Import TreeProvider

class TraversalButton2<T extends TreeProvider2> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BFSDFSProvider>(context);
    return ElevatedButton(
      onPressed: () {
        provider.performTraversal2(provider.nodes[0], isBFS: false); // Perform BFS
      },
      child: Text("Start BFS"),
    );
  }
}
