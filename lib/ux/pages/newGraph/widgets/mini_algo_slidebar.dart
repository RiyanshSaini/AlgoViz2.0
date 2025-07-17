import 'package:algo_visualizer/ux/pages/newGraph/widgets/smart_dijkstra_panel.dart';
import 'package:flutter/material.dart';

import '../../../../providers/newGraph/graph_provider.dart';
import 'draggable_bfs_queue_panel.dart';
import 'draggable_stack_pannel.dart';

class MiniAlgorithmSlideBar extends StatelessWidget {
  final String algorithm;
  final bool isPanelVisible;
  final VoidCallback onTogglePanel;

  const MiniAlgorithmSlideBar({
    super.key,
    required this.algorithm,
    required this.isPanelVisible,
    required this.onTogglePanel,
  });

  Map<String, Map<String, String>> get algoInfo => {
    "DFS": {"time": "O(V + E)", "space": "O(V)"},
    "BFS": {"time": "O(V + E)", "space": "O(V)"},
    "Dijkstra": {"time": "O(V log V)", "space": "O(V)"},
  };

  @override
  Widget build(BuildContext context) {
    final info = algoInfo[algorithm]!;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 200,
        maxWidth: 240,
        minHeight: 180,
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.85),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.analytics, color: Colors.white70),
                  const SizedBox(height: 8),
                  Text(
                    "Time: ${info["time"]}",
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  Text(
                    "Space: ${info["space"]}",
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Inside Column children[] in MiniAlgorithmSlideBar:
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  isPanelVisible ? Icons.visibility_off : Icons.visibility,
                  size: 18,
                  color: Colors.black,
                ),
                tooltip: const Text("This is the text" , style: TextStyle(color: Colors.black),).toString(),
                onPressed: onTogglePanel,
              ),
            ),

            // ElevatedButton.icon(
            //   onPressed: onTogglePanel,
            //   icon: Icon(isPanelVisible ? Icons.visibility_off : Icons.visibility),
            //   label: Text(
            //     switch (algorithm) {
            //       "DFS" => isPanelVisible ? "Hide Stack" : "Show Stack",
            //       "BFS" => isPanelVisible ? "Hide Queue" : "Show Queue",
            //       "Dijkstra" => isPanelVisible ? "Hide Priority Queue" : "Show Priority Queue",
            //       _ => "Toggle",
            //     },
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.deepPurple,
            //     foregroundColor: Colors.white,
            //     minimumSize: const Size(120, 40),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}