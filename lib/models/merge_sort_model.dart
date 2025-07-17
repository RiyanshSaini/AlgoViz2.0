import 'package:algo_visualizer/models/sort_model.dart';

class MergeSortNode {
  List<SortModel> values;
  int level;
  MergeSortNode? left;
  MergeSortNode? right;

  MergeSortNode({
    required this.values,
    required this.level,
    this.left,
    this.right,
  });

  void markAsMerging() {
    for (var value in values) {
      value.sort(); // Mark as being sorted
    }
  }

}
