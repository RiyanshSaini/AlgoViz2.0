import 'package:algo_visualizer/providers/tree_provider2.dart';
import 'package:algo_visualizer/ux/widgets/tree_traversals/animated_tree_vis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../providers/dummy_tree_provider.dart';
import '../../../providers/tree_provider.dart';
import '../../../providers/trees_traversal/dfs_provider.dart';
import '../../widgets/tree_traversals/reset_button.dart';
import '../../widgets/tree_traversals/speed_control_slider.dart';
import '../../widgets/tree_traversals/traversal2.dart';
import '../../widgets/tree_traversals/traversal_button.dart';


class DFSPage extends StatefulWidget {
  const DFSPage({super.key});

  @override
  _DFSPageState createState() => _DFSPageState();
}

class _DFSPageState extends State<DFSPage> {
  final GlobalKey<AnimatedTreeVisualizerState> treeKey = GlobalKey(); // ✅ GlobalKey

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DummyTreeProvider(),
      child: Consumer<DummyTreeProvider>(
        builder: (context, treeProvider, child) {
          print("Root Node Value: ${treeProvider.root.value}");
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: AnimatedTreeVisualizer(
                        key: treeKey, // ✅ Pass GlobalKey to AnimatedTreeVisualizer
                        root: treeProvider.root,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TraversalButton<TreeProvider>(),
                        SpeedControlSlider<TreeProvider>(),
                        ResetButton(treeKey: treeKey), // ✅ Pass treeKey to ResetButton
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
