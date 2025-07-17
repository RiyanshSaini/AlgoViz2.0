import 'package:flutter/material.dart';
import 'glassbox.dart';

class DraggablePriorityQueuePanel extends StatefulWidget {
  final List<String> queue;
  final Map<String, int> distances;
  final String? currentNode;
  final String? operation; // "extract", "update"

  const DraggablePriorityQueuePanel({
    super.key,
    required this.queue,
    required this.distances,
    required this.currentNode,
    required this.operation,
  });

  @override
  State<DraggablePriorityQueuePanel> createState() =>
      _DraggablePriorityQueuePanelState();
}

class _DraggablePriorityQueuePanelState
    extends State<DraggablePriorityQueuePanel> {
  Offset position = const Offset(16, 420);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) => setState(() => position += details.delta),
        child: GlassBox(
          width: 360,
          height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Dijkstra: Priority Queue",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 2)],
                ),
              ),
              const SizedBox(height: 6),

              if (widget.operation != null)
                Text(
                  widget.operation == 'extract'
                      ? "Extract-Min Node"
                      : "Distance Updated (Relax)",
                  style: TextStyle(
                    color: widget.operation == 'extract'
                        ? Colors.redAccent
                        : Colors.greenAccent,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),

              const SizedBox(height: 8),

              // Queue content
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.queue.map((id) {
                    final isActive = id == widget.currentNode;
                    final dist = widget.distances[id] ?? 99999;

                    return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    width: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isActive
                            ? Colors.orange
                            : Colors.white.withOpacity(0.1),
                        border: Border.all(
                          color: isActive
                              ? Colors.orangeAccent
                              : Colors.white24,
                          width: isActive ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.white,
                            child: Text(
                              id,
                              style: const TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "d: $dist",
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 12),
                          ),
                          if (id == widget.queue.first)
                            const Text("Min",
                                style: TextStyle(
                                    color: Colors.tealAccent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
