import 'package:flutter/material.dart';

import 'glassbox.dart';

class DraggableDfsStackPanel extends StatefulWidget {
  final List<String> stack;
  final String? currentNode;
  final String? operation;

  const DraggableDfsStackPanel({
    super.key,
    required this.stack,
    required this.currentNode,
    required this.operation,
  });

  @override
  State<DraggableDfsStackPanel> createState() => _DraggableDfsStackPanelState();
}

class _DraggableDfsStackPanelState extends State<DraggableDfsStackPanel> {
  Offset position = const Offset(16, 100);

  @override
  Widget build(BuildContext context) {
    final reversed = widget.stack;

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() => position += details.delta);
        },
        child: GlassBox(
          width: 180,
          height: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Stack Title
              const Text(
                "DFS Stack",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 2)],
                ),
              ),
              const SizedBox(height: 8),

              // Operation Arrow
              if (widget.operation != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.operation == 'push'
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: widget.operation == 'push'
                          ? Colors.greenAccent
                          : Colors.redAccent,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.operation == 'push' ? "Push" : "Pop",
                      style: TextStyle(
                        color: widget.operation == 'push'
                            ? Colors.greenAccent
                            : Colors.redAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 8),

              // Stack Visualization (top on top)
              Expanded(
                child: ListView.builder(
                  itemCount: reversed.length,
                  itemBuilder: (context, i) {
                    final id = reversed[i];
                    final isTop = i == 0;
                    final isBottom = i == reversed.length - 1;
                    final isSingle = reversed.length == 1;
                    final isActive = id == widget.currentNode;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isActive
                              ? [Colors.orange, Colors.deepOrangeAccent]
                              : isTop
                              ? [Colors.deepPurpleAccent, Colors.purple]
                              : [Colors.white12, Colors.black26],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isTop ? Colors.white : Colors.white30,
                          width: isTop ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                            child: Text(
                              id,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "Node $id",
                              style: const TextStyle(color: Colors.white, fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4),
                          if (isSingle)
                            const Text("Top & Bottom",
                                style: TextStyle(fontSize: 10, color: Colors.white70)),
                          if (!isSingle && isTop)
                            const Text("Top", style: TextStyle(fontSize: 10, color: Colors.white)),
                          if (!isSingle && isBottom)
                            const Text("Bottom",
                                style: TextStyle(fontSize: 10, color: Colors.white54)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// previous one
// class DraggableStackPanel extends StatefulWidget {
//   final Widget child;
//
//   const DraggableStackPanel({super.key, required this.child});
//
//   @override
//   State<DraggableStackPanel> createState() => _DraggableStackPanelState();
// }
//
// class _DraggableStackPanelState extends State<DraggableStackPanel> {
//   Offset position = const Offset(20, 50);
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       left: position.dx,
//       top: position.dy,
//       child: GestureDetector(
//         onPanUpdate: (details) {
//           setState(() {
//             position += details.delta;
//           });
//         },
//         child: widget.child,
//       ),
//     );
//   }
// }
