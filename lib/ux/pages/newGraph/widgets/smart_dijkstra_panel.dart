import 'package:flutter/material.dart';
import 'glassbox.dart';

class SmartDijkstraPanel extends StatefulWidget {
  final List<String> queue;
  final Map<String, int> distances;
  final Set<String> relaxedNodes;
  final String? currentExtracted;

  const SmartDijkstraPanel({
    super.key,
    required this.queue,
    required this.distances,
    required this.relaxedNodes,
    required this.currentExtracted,
  });

  @override
  State<SmartDijkstraPanel> createState() => _SmartDijkstraPanelState();
}

class _SmartDijkstraPanelState extends State<SmartDijkstraPanel> {
  Offset position = const Offset(20, 420);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) => setState(() => position += details.delta),
        child: GlassBox(
          width: 380,
          height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Dijkstra Priority Queue",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 2)],
                ),
              ),
              const SizedBox(height: 6),

              // Cards of current queue
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.queue.map((id) {
                    final dist = widget.distances[id] ?? 99999;
                    final isExtract = id == widget.currentExtracted;
                    final isRelaxed = widget.relaxedNodes.contains(id);

                    Color bgColor = Colors.white12;
                    if (isExtract) {
                      bgColor = Colors.yellowAccent.withOpacity(0.7);
                    } else if (isRelaxed) {
                      bgColor = Colors.greenAccent.withOpacity(0.4);
                    }

                    return Container(
                      width: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isExtract
                              ? Colors.yellow
                              : isRelaxed
                              ? Colors.green
                              : Colors.white24,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            id,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "d = ${dist == 99999 ? "∞" : dist}",
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 12),
                          ),
                          if (isExtract)
                            const Text("Extract",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black87)),
                          if (!isExtract && isRelaxed)
                            const Text("Relaxed",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black54)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 10),

              // Explanation
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: const [
                    Icon(Icons.lightbulb_outline, color: Colors.yellow, size: 16),
                    SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        "Greedy pick = node with smallest distance (Extract-Min)",
                        style: TextStyle(
                            fontSize: 11, color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              const Divider(color: Colors.white24, height: 8),

              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  LegendBox(color: Colors.yellowAccent, label: "Extract-Min"),
                  LegendBox(color: Colors.greenAccent, label: "Relaxed"),
                  LegendBox(color: Colors.white30, label: "Waiting"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LegendBox extends StatelessWidget {
  final Color color;
  final String label;
  const LegendBox({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color, margin: const EdgeInsets.only(right: 6)),
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10)),
      ],
    );
  }
}
