import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/node.dart';
import '../../../providers/graphs/graph_provider_NotUsing.dart';

class NodeWidget extends StatelessWidget {
  final Node node;

  const NodeWidget({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _startEdgeCreation(context),
      child: Draggable(
        feedback: _buildNodeCircle(),
        child: _buildNodeCircle(),
        onDragEnd: (details) => _updatePosition(context, details),
      ),
    );
  }

  Widget _buildNodeCircle() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Center(child: Text(node.value)),
    );
  }

  void _updatePosition(BuildContext context, DraggableDetails details) {
    final graphProvider = Provider.of<GraphProviderNotUsing>(context, listen: false);
    node.position = details.offset;
    graphProvider.notifyListeners();
  }

  void _startEdgeCreation(BuildContext context) {
    // Highlight node and wait for target selection
  }
}