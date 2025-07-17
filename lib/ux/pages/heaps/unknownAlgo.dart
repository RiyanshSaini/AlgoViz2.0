import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/node.dart';
import '../../../providers/graphs/graph_provider_NotUsing.dart';
import '../../widgets/graphs/graph_board.dart';
import '../../widgets/graphs/physics_simulator.dart';


class UnknownAlgo extends StatelessWidget {
  const UnknownAlgo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => GraphProviderNotUsing(),
        child: const GraphBoard(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNode(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNode(BuildContext context) {
    final provider = Provider.of<GraphProviderNotUsing>(context, listen: false);
    provider.addNode(Node(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      value: '${provider.nodes.length + 1}',
      position: const Offset(200, 200),
    ));
  }
}