import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/trees_traversal/bfs_provider.dart';
import '../../widgets/tree_traversals/animated_tree_vis.dart';
import '../../widgets/tree_traversals/animated_tree_vis2.dart';
import '../../widgets/tree_traversals/reset_button.dart';
import '../../widgets/tree_traversals/speed_control_slider.dart';
import '../../widgets/tree_traversals/traversal2.dart';
import '../../widgets/tree_traversals/traversal_button.dart';

class BFSPage extends StatefulWidget {
  const BFSPage({super.key});

  @override
  _BFSPageState createState() => _BFSPageState();
}

class _BFSPageState extends State<BFSPage> {
  final GlobalKey<AnimatedTreeVisualizerState> treeKey = GlobalKey(); // ✅ GlobalKey

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BFSDFSProvider(), // Use BFSDFSProvider instead of DummyTreeProvider
      child: Consumer<BFSDFSProvider>(
        builder: (context, treeProvider, child) {
          print("Root Node Value: ${treeProvider.nodes[0].value}");
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: AnimatedTreeVisualizer2(
                        key: treeKey, // ✅ Pass GlobalKey to AnimatedTreeVisualizer
                        root: treeProvider.nodes[0], // Use the root node from the provider
                        isBFS: true, // Set isBFS to true for BFS traversal
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TraversalButton2<BFSDFSProvider>(), // Use BFSDFSProvider
                        SpeedControlSlider<BFSDFSProvider>(), // Use BFSDFSProvider
                        // ResetButton(treeKey: treeKey), // ✅ Pass treeKey to ResetButton
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

