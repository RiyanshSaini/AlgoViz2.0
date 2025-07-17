import 'package:algo_visualizer/ux/widgets/sort/sort_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/merge_sort_model.dart';
import '../../../providers/sort/merge_sort_provider.dart';

class MergeSortTreeVisualizer extends StatelessWidget {
  const MergeSortTreeVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MergeSortProvider>(
      builder: (_, provider, __) {
        return provider.root != null
            ? SingleChildScrollView( // Make the content scrollable
          child: _buildTree(provider.root!, MediaQuery.of(context).size.width),
        )
            : Center(child: Text("Press Sort to Start"));
      },
    );
  }

  Widget _buildTree(MergeSortNode node, double width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min, // Minimize the height of the Column
      children: [
        // Display the current node
        SingleChildScrollView( // Add scroll for overflow
          scrollDirection: Axis.horizontal, // Allow horizontal scrolling
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: node.values.map((e) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 500),
                margin: EdgeInsets.all(4),
                width: 40, // Keep consistent block size
                height: 40, // Fixed height for better alignment
                child: SortWidget(
                  key: ValueKey(e.value), // Fix: Generate a new key dynamically
                  number: e,
                  index: node.values.indexOf(e),
                  widgetSize: 40,
                  containerWidth: width,
                ),
              );
            }).toList(),
          ),
        ),

        // Display children nodes (left and right sub-arrays)
        if (node.left != null && node.right != null)
          SizedBox(
            width: width, // Ensure total width is respected
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible( // Use Flexible to constrain width
                  child: _buildTree(node.left!, width / 2), // Allocate half width
                ),
                SizedBox(width: 20), // Add spacing to prevent overflow
                Flexible(
                  child: _buildTree(node.right!, width / 2),
                ),
              ],
            ),
          ),
      ],
    );
  }
}