import 'package:flutter/material.dart';
class StackViewPanel extends StatelessWidget {
  final List<String> stack;
  final String? currentNode;
  final String? operation; // "push", "pop", or null
  final bool isVisible;

  const StackViewPanel({
    super.key,
    required this.stack,
    required this.currentNode,
    required this.operation,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🧠 Title
          const Text(
            "DFS Stack",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),

          // 🌀 Animated Stack Visualization
          Container(
            height: 240,
            child: ListView.builder(
              reverse: true,
              itemCount: stack.length,
              itemBuilder: (context, index) {
                final isTop = index == stack.length - 1;
                final id = stack.reversed.toList()[index];
                final isActive = id == currentNode;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.redAccent
                        : isTop
                        ? Colors.deepPurple
                        : Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isTop ? Colors.white : Colors.transparent,
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
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isTop ? "Top → $id" : "Node $id",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // 🟢 Operation Indicator
          if (operation != null)
            Row(
              children: [
                Icon(
                  operation == "push"
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  operation == "push" ? "Pushing…" : "Popping…",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

