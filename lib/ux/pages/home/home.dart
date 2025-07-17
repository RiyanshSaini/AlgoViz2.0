
import 'package:algo_visualizer/providers/search/binary_search_provider.dart';
import 'package:algo_visualizer/providers/sort/selection_sort_provider.dart';
import 'package:algo_visualizer/ux/pages/heaps/heapVisualizer.dart';
import 'package:algo_visualizer/ux/pages/heaps/unknownAlgo.dart';
import 'package:algo_visualizer/ux/pages/newGraph/graph_test_page.dart';
import 'package:algo_visualizer/ux/pages/search_pages/binary_search_page.dart';
import 'package:algo_visualizer/ux/pages/sort_page.dart';
import 'package:algo_visualizer/ux/pages/sort_pages/insertion_sort_page.dart';
import 'package:algo_visualizer/ux/pages/tree_traversals/bfs.dart';
import 'package:flutter/material.dart';
import '../search_pages/linear_search_page.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../sort_pages/bubble_sort_page.dart';
import '../sort_pages/merge_sort_page.dart';
import '../sort_pages/quick_sort_page.dart';
import '../sort_pages/selection_sort_page.dart';
import '../tree_traversals/dfs.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();

  // ✅ Enum-based navigation for better maintainability
  final List<Widget> pages = [
    // const HeapVisualizer(),
    // const UnknownAlgo(),

    const GraphTestPage(),

  ];

  int _currentIndex = 0;

  void _navigateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300), // ✅ Smooth animation
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _navigateToPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.energy_savings_leaf), label: "DFS"),
          BottomNavigationBarItem(icon: Icon(Icons.sort), label: "Merge Sort"),
          BottomNavigationBarItem(icon: Icon(Icons.fast_forward), label: "Quick Sort"),
          BottomNavigationBarItem(icon: Icon(Icons.bubble_chart), label: "Bubble Sort"),
          BottomNavigationBarItem(icon: Icon(Icons.select_all), label: "Selection Sort"),
          BottomNavigationBarItem(icon: Icon(Icons.insert_chart), label: "Insertion Sort"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Linear Search"),
          BottomNavigationBarItem(icon: Icon(Icons.search_off), label: "Binary Search"),
        ],
      ),
    );
  }
}
