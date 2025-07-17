
import 'package:algo_visualizer/ux/widgets/newGraph/edge_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/newGraph/graph_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edge_painter.dart';

class GraphCanvas extends StatelessWidget {
  const GraphCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GraphProvider>(
      builder: (context, graph, child) {
        return Stack(
          children: [
            // Draw edges behind nodes
            CustomPaint(
              size: Size.infinite,
              painter: EdgePainter(graph.nodes, graph.edges),
            ),

            // Gesture detectors over edge midpoints
            ...graph.edges.map((edge) {
              final from = graph.nodes.firstWhere((n) => n.id == edge.fromNodeId);
              final to = graph.nodes.firstWhere((n) => n.id == edge.toNodeId);

              final center = Offset(
                (from.position.dx + to.position.dx) / 2,
                (from.position.dy + to.position.dy) / 2,
              );

              return Positioned(
                left: center.dx - 15, // offset to center the gesture zone
                top: center.dy - 15,
                child: GestureDetector(
                  onLongPress: () {
                    Provider.of<GraphProvider>(context, listen: false)
                        .removeEdge(edge.fromNodeId, edge.toNodeId);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    color: Colors.transparent, // invisible click zone
                  ),
                ),
              );
            }),

            // Draggable and tappable nodes
            ...graph.nodes.map((node) {
              final isSelected = graph.selectedNode?.id == node.id;
              final isPath = node.isPath;

              return Positioned(
                left: node.position.dx,
                top: node.position.dy,
                child: GestureDetector(
                  onTap: () {
                    final graphProvider = Provider.of<GraphProvider>(context, listen: false).selectNode(node);
                    // if (graphProvider.selectedNode != null) {
                    //   // Selected node is source, tapped node is destination
                    //   graphProvider.highlightPathTo(node.id);
                    // } else {
                    //   graphProvider.selectNode(node);
                    // }
                  },
                  onPanUpdate: (details) {
                    final newPosition = node.position + details.delta;
                    Provider.of<GraphProvider>(context, listen: false)
                        .updateNodePosition(node.id, newPosition);
                  },
                  onLongPress: () {
                    Provider.of<GraphProvider>(context, listen: false).removeNode(node.id);
                  },
                  child: CircleAvatar(
                    backgroundColor: isSelected
                  ? Colors.orange
                      : isPath
                  ? Colors.green
                      : node.visited
                  ? Colors.redAccent
                      : Colors.blueAccent,
                    radius: 25,
                    child: Text(
                      node.id,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
