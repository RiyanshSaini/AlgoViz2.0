

import '../../models/sort_model.dart';
import '../sort_provider.dart';

class InsertionSortProvider extends SortProvider {
  @override
  void sort() {
    if (isSorting) return; // Prevent duplicate sorting calls
    super.sort();
    _startSort(numbers); // Don't reset numbers before sorting
  }

  Future _startSort(List<SortModel> list) async {
    for (var i = 0; i < list.length; i++) {
      if (i > 1) {
        markNodesAsNotSorted(0, i - 2);
      }
      for (var j = i; j > 0 && (list[j].value < list[j - 1].value); j--) {
        markNodesForSorting(j - 1, j);
        await pause();
        render();

        // Swap without causing an extra UI rebuild
        final tmp = list[j];
        list[j] = list[j - 1];
        list[j - 1] = tmp;

        await pause();
        render();
        markNodeAsNotSorted(j);
      }
    }
    markNodesAsSorted(0, list.length - 1);
    setStateToSorted();
  }
}
