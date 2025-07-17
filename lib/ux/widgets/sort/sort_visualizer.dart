import 'package:algo_visualizer/ux/widgets/sort/sort_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/sort_provider.dart';

class SortVisualizer<T extends SortProvider> extends StatelessWidget {
  const SortVisualizer({
    super.key,
    this.spacing = 8, // Define spacing between numbers
  });

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (_, provider, __) {
        final int itemCount = provider.numbers.length;
        final double screenWidth = MediaQuery.of(context).size.width;
        final double maxWidth = screenWidth * 0.9; // Use 90% of screen width

        // Ensure we don't divide by zero and calculate block size dynamically
        final double blockSize = itemCount > 0
            ? ((maxWidth - (spacing * (itemCount - 1))) / itemCount).clamp(20, maxWidth / 5)
            : 40;

        return SizedBox(
          width: maxWidth,
          child: Wrap(
            spacing: spacing,
            alignment: WrapAlignment.center,
            children: provider.numbers.map((number) {
              return SizedBox(
                width: blockSize,
                child: SortWidget(
                  key: number.key,
                  number: number,
                  index: provider.numbers.indexOf(number),
                  widgetSize: blockSize,
                  containerWidth: maxWidth,
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
