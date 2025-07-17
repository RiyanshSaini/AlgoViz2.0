import 'package:flutter/material.dart';
import 'glassbox.dart';

class DraggableBfsQueuePanel extends StatefulWidget {
  final List<String> queue;
  final String? currentNode;
  final String? operation; // "enqueue", "dequeue"

  const DraggableBfsQueuePanel({
    super.key,
    required this.queue,
    required this.currentNode,
    required this.operation,
  });

  @override
  State<DraggableBfsQueuePanel> createState() =>
      _DraggableBfsQueuePanelState();
}

class _DraggableBfsQueuePanelState extends State<DraggableBfsQueuePanel> {
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
          height: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "BFS Queue",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 2)],
                ),
              ),
              const SizedBox(height: 6),

              // Operation label
              if (widget.operation != null)
                Text(
                  widget.operation == 'enqueue'
                      ? "Enqueueing Node →"
                      : "Dequeuing Node ←",
                  style: TextStyle(
                    color: widget.operation == 'enqueue'
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),

              const SizedBox(height: 8),

              // Queue Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.queue.map((id) {
                    final isFront = id == widget.queue.first;
                    final isRear = id == widget.queue.last;
                    final isActive = id == widget.currentNode;
                    final isSingle = widget.queue.length == 1;

                    return Column(
                      children: [
                        Container(
                          width: 40,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.orange
                                : Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isFront
                                  ? Colors.tealAccent
                                  : isRear
                                  ? Colors.deepPurpleAccent
                                  : Colors.white30,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              id,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (isSingle)
                          const Text("Front & Rear",
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white60)),
                        if (!isSingle && isFront)
                          const Text("Front",
                              style: TextStyle(
                                  fontSize: 10, color: Colors.tealAccent)),
                        if (!isSingle && isRear)
                          const Text("Rear",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.deepPurpleAccent)),
                      ],
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
