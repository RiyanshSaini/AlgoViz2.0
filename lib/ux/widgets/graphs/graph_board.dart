import 'dart:async'as async;
import 'package:algo_visualizer/ux/widgets/graphs/physics_simulator.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../../models/node.dart';
import '../../../providers/graphs/graph_provider_NotUsing.dart';
import 'graph_painter.dart';
import 'package:provider/provider.dart';

class GraphBoard extends StatefulWidget {
  const GraphBoard({super.key});

  @override
  State<GraphBoard> createState() => _GraphBoardState();
}

class _GraphBoardState extends State<GraphBoard> {
  String? _draggedNodeId;
  final _physics = PhysicsSimulator();
  late final async.Timer _timer; // Use the aliased Timer consistently

  @override
  void initState() {
    super.initState();
    _timer = async.Timer.periodic(const Duration(milliseconds: 16), (_) {
      final provider = Provider.of<GraphProviderNotUsing>(context, listen: false);
      _physics.update(provider.nodes);
      setState(() {});
    }); // Removed the 'as Timer' cast
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GraphProviderNotUsing>(context);

    return Stack(
      children: [
        GestureDetector(
          child: CustomPaint(
            painter: GraphPainter(
              nodes: provider.nodes,
              edges: provider.edges,
              selectedNodeId: provider.selectedNodeId,
            ),
            child: _buildInteractiveNodes(provider),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: FloatingActionButton(
            onPressed: () => _showAddNodeDialog(context),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveNodes(GraphProviderNotUsing provider) {
    return Stack(
      children: provider.nodes.map((node) {
        return Positioned(
          left: node.position.dx - node.radius,
          top: node.position.dy - node.radius,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (details) {
              setState(() => _draggedNodeId = node.id);
            },
            onPanUpdate: (details) {
              final newPosition = node.position + details.delta;
              _physics.dragNode(node.id, newPosition);
            },
            onPanEnd: (_) => setState(() => _draggedNodeId = null),
            onLongPress: () => provider.createEdge(node.id),
            child: Container(
              width: node.radius * 2,
              height: node.radius * 2,
              decoration: BoxDecoration(
                color: provider.selectedNodeId == node.id
                    ? Colors.orange
                    : Colors.red,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                node.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: node.radius * 0.6,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showAddNodeDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Node"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter node value"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                final provider = Provider.of<GraphProviderNotUsing>(context, listen: false);
                final newNode = Node(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  value: value,
                  position: const Offset(100, 100), // Default position
                );
                provider.addNode(newNode);
                _physics.addNode(newNode);
              }
              Navigator.of(context).pop();
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
