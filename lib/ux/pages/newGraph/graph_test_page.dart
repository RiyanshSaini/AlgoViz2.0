import 'package:algo_visualizer/ux/pages/newGraph/widgets/draggable_bfs_queue_panel.dart';
import 'package:algo_visualizer/ux/pages/newGraph/widgets/draggable_dijkstra_priority_queue_panel.dart';
import 'package:algo_visualizer/ux/pages/newGraph/widgets/draggable_stack_pannel.dart';
import 'package:algo_visualizer/ux/pages/newGraph/widgets/mini_algo_slidebar.dart';
import 'package:algo_visualizer/ux/pages/newGraph/widgets/smart_dijkstra_panel.dart';
import '../../../GraphMode/graph_mode.dart';
import '../../../providers/newGraph/graph_provider.dart';
import '../../widgets/newGraph/graph_canvas.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphTestPage extends StatefulWidget {
  const GraphTestPage({super.key});

  @override
  State<GraphTestPage> createState() => _GraphTestPageState();
}

class _GraphTestPageState extends State<GraphTestPage> {
  String selectedAlgorithm = 'DFS';
  bool showInternalPanel = true;
  bool showInternalStructurePanel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Graph Visualizer'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        shadowColor: Colors.deepPurple.withOpacity(0.3),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// Top Algorithm Selection Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Consumer<GraphProvider>(
                      builder: (context, graph, child) {
                        return DropdownButtonFormField<String>(
                          value: selectedAlgorithm,
                          decoration: InputDecoration(
                            labelText: "Algorithm",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          dropdownColor: Colors.white,
                          items: ['DFS', 'BFS', 'Dijkstra', 'A* (Coming Soon)']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue == null || newValue.contains('Coming'))
                              return;
                            setState(() => selectedAlgorithm = newValue);

                            final startNodeId = graph.selectedNode?.id ??
                                (graph.nodes.isNotEmpty
                                    ? graph.nodes.first.id
                                    : null);

                            if (startNodeId != null) {
                              graph.setMode(GraphMode.runningAlgorithm);
                              switch (selectedAlgorithm) {
                                case 'DFS':
                                  graph.dfs(startNodeId);
                                  break;
                                case 'BFS':
                                  graph.bfs(startNodeId);
                                  break;
                                case 'Dijkstra':
                                  graph.dijkstra(startNodeId);
                                  break;
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please add nodes first")),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                      showInternalPanel ? Icons.info_outline : Icons.info,
                      color: Colors.deepPurple,
                    ),
                    onPressed: () =>
                        setState(() => showInternalPanel = !showInternalPanel),
                    tooltip: 'Algorithm Info',
                  ),
                ],
              ),
            ),

            /// Main Content Area
            Expanded(
              child: Stack(
                children: [
                  /// Graph Canvas
                  const GraphCanvas(),

                  /// Algorithm Info Panel (Left Side)
                  /// Sidebar with toggle
                  Positioned(
                    top: 10,
                    bottom: 10,
                    left: 10,
                    child: Row(
                      children: [
                        /// Sidebar panel (animates in and out)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: showInternalPanel ? 240 : 0,
                          curve: Curves.easeInOut,
                          child: AnimatedOpacity(
                            opacity: showInternalPanel ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: showInternalPanel
                                ? Material(
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      constraints:
                                          const BoxConstraints(maxHeight: 400),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 10,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: SingleChildScrollView(
                                        padding: const EdgeInsets.all(12),
                                        child: Consumer<GraphProvider>(
                                          builder: (context, graph, child) {
                                            return MiniAlgorithmSlideBar(
                                              algorithm: selectedAlgorithm,
                                              isPanelVisible:
                                                  showInternalStructurePanel,
                                              onTogglePanel: () {
                                                setState(() {
                                                  showInternalStructurePanel =
                                                      !showInternalStructurePanel;
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox
                                    .shrink(), // Prevent layout/render of panel
                          ),
                        ),

                        /// Internal Visualization Panels
                        // Consumer<GraphProvider>(
                        //   builder: (context, graph, child) {
                        //     if (!showInternalStructurePanel)
                        //       return const SizedBox();
                        //
                        //     if (selectedAlgorithm == 'DFS') {
                        //       return DraggableDfsStackPanel(
                        //         stack: graph.dfsStack,
                        //         currentNode: graph.currentStackNode,
                        //         operation: graph.stackOperation,
                        //       );
                        //     }
                        //
                        //     if (selectedAlgorithm == 'BFS') {
                        //       return DraggableBfsQueuePanel(
                        //         queue: graph.bfsQueue,
                        //         currentNode: graph.bfsCurrentNode,
                        //         operation: graph.bfsOperation,
                        //       );
                        //     }
                        //
                        //     if (selectedAlgorithm == 'Dijkstra') {
                        //       return SmartDijkstraPanel(
                        //         queue: graph.priorityQueue,
                        //         distances: graph.distances,
                        //         relaxedNodes: graph.relaxedNodes,
                        //         currentExtracted: graph.currentExtractedNode,
                        //       );
                        //     }
                        //
                        //     return const SizedBox();
                        //   },
                        // ),

                        /// Always-visible toggle handle
                        GestureDetector(
                          onTap: () => setState(
                              () => showInternalPanel = !showInternalPanel),
                          child: Container(
                            width: 30,
                            height: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(12),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Icon(
                              showInternalPanel
                                  ? Icons.arrow_back_ios_new_rounded
                                  : Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Internal Structure Panel (e.g., Stack, Queue, PriorityQueue)
                  if (showInternalStructurePanel)
                    Consumer<GraphProvider>(
                      builder: (context, graph, child) {
                        switch (selectedAlgorithm) {
                          case 'DFS':
                            return DraggableDfsStackPanel(stack: graph.dfsStack, currentNode: graph.currentStackNode, operation: graph.stackOperation,); // Replace with actual widget
                          case 'BFS':
                            return  DraggableBfsQueuePanel(queue: graph.bfsQueue, currentNode: graph.bfsCurrentNode, operation: graph.bfsCurrentNode, ); // Replace with actual widget
                          case 'Dijkstra':
                            return DraggablePriorityQueuePanel(
                              queue: graph.priorityQueue,
                              distances: graph.distances,
                              currentNode: graph.pqCurrentNode,
                              operation: graph.pqOperation,
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),

                ],
              ),
            ),

            /// Bottom Control Panel
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Consumer<GraphProvider>(
                builder: (context, graph, child) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Chip(
                            label: Text(
                              "Mode: ${graph.mode.toString().split('.').last}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.deepPurple,
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: () {
                              graph.setMode(GraphMode.connecting);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Edge Mode: Tap 2 nodes to connect")),
                              );
                            },
                            icon: const Icon(Icons.link, size: 18),
                            label: const Text("Connect"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: graph.resetTraversal,
                            icon: const Icon(Icons.refresh, size: 18),
                            label: const Text("Reset"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Tip: Tap on nodes to select them",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),

      /// Add Node Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final graphProvider =
              Provider.of<GraphProvider>(context, listen: false);
          final position = Offset(
            MediaQuery.of(context).size.width / 2 + Random().nextInt(100) - 50,
            MediaQuery.of(context).size.height / 2 + Random().nextInt(100) - 50,
          );
          graphProvider.addNode(position);
        },
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
