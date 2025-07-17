import '../../models/merge_sort_model.dart';
import '../../models/sort_model.dart';
import '../sort_provider.dart';

class MergeSortProvider extends SortProvider {
  MergeSortNode? _root;
  MergeSortNode? get root => _root;

  @override
  void sort() {
    super.sort();
    _root = _buildMergeSortTree(numbers, 0);
    notifyListeners();
    _performMergeSort(_root);
  }

  MergeSortNode _buildMergeSortTree(List<SortModel> list, int level) {
    if (list.length <= 1) {
      return MergeSortNode(values: List.from(list), level: level);
    }

    int mid = list.length ~/ 2;
    List<SortModel> leftList = List.from(list.sublist(0, mid));
    List<SortModel> rightList = List.from(list.sublist(mid));

    return MergeSortNode(
      values: List.from(list),
      level: level,
      left: _buildMergeSortTree(leftList, level + 1),
      right: _buildMergeSortTree(rightList, level + 1),
    );
  }

  Future<void> _performMergeSort(MergeSortNode? node) async {
    if (node == null || node.values.length <= 1) return;

    await _performMergeSort(node.left);
    await _performMergeSort(node.right);

    // Mark nodes as being merged
    node.markAsMerging();
    notifyListeners();
    await _pause(); // Use a proper pause function

    // Merge elements with step-by-step animation
    await _mergeWithAnimation(node);

    // Mark final sorted state
    node.values.forEach((e) => e.sorted());
    notifyListeners();
    await _pause(); // Use a proper pause function
  }

  Future<void> _mergeWithAnimation(MergeSortNode node) async {
    List<SortModel> left = node.left!.values.map((e) => e.clone()).toList();
    List<SortModel> right = node.right!.values.map((e) => e.clone()).toList();
    List<SortModel> merged = [];

    int i = 0, j = 0;

    while (i < left.length && j < right.length) {
      // ✅ Highlight only at the next merge level
      node.left!.values[i].highlight();
      node.right!.values[j].highlight();
      notifyListeners();
      await _pause();

      if (left[i].value <= right[j].value) {
        left[i].sort();
        merged.add(left[i]);
        i++;
      } else {
        right[j].sort();
        merged.add(right[j]);
        j++;
      }

      // ✅ Update **only the current node**
      node.values = merged.map((e) => e.clone()).toList();
      notifyListeners();
      await _pause();

      // ✅ Remove highlight only from **current** level
      if (i > 0) node.left!.values[i - 1].clearHighlight();
      if (j > 0) node.right!.values[j - 1].clearHighlight();
      notifyListeners();
      await _pause();
    }

    while (i < left.length) {
      node.left!.values[i].highlight();
      notifyListeners();
      await _pause();

      left[i].sort();
      merged.add(left[i]);
      i++;

      node.values = merged.map((e) => e.clone()).toList();
      notifyListeners();
      await _pause();

      node.left!.values[i - 1].clearHighlight();
      notifyListeners();
      await _pause();
    }

    while (j < right.length) {
      node.right!.values[j].highlight();
      notifyListeners();
      await _pause();

      right[j].sort();
      merged.add(right[j]);
      j++;

      node.values = merged.map((e) => e.clone()).toList();
      notifyListeners();
      await _pause();

      node.right!.values[j - 1].clearHighlight();
      notifyListeners();
      await _pause();
    }
  }



  // Proper pause function
  Future<void> _pause() async {
    await Future.delayed(Duration(milliseconds: 500)); // Adjust delay as needed
  }
}