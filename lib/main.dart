import 'package:algo_visualizer/providers/dummy_tree_provider.dart';
import 'package:algo_visualizer/providers/graphs/graph_provider_NotUsing.dart';
import 'package:algo_visualizer/providers/graphs/physics_provider.dart';
import 'package:algo_visualizer/providers/newGraph/graph_provider.dart';
import 'package:algo_visualizer/providers/search/binary_search_provider.dart';
import 'package:algo_visualizer/providers/search/linear_search_provider.dart';
import 'package:algo_visualizer/providers/sort/bubble_sort_provider.dart';
import 'package:algo_visualizer/providers/sort/insertion_sort_provider.dart';
import 'package:algo_visualizer/providers/sort/merge_sort_provider.dart';
import 'package:algo_visualizer/providers/sort/quick_sort_provider.dart';
import 'package:algo_visualizer/providers/sort/selection_sort_provider.dart';
import 'package:algo_visualizer/providers/sort_provider.dart';
import 'package:algo_visualizer/providers/tree_provider.dart';
import 'package:algo_visualizer/providers/trees_traversal/bfs_provider.dart';
import 'package:algo_visualizer/providers/trees_traversal/dfs_provider.dart';
import 'package:algo_visualizer/ux/pages/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Algorithms',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => GraphProvider()),
            // ChangeNotifierProvider(create: (_) => SortProvider()),
            ChangeNotifierProvider(create: (_) => DummyTreeProvider()), // ✅ Base TreeProvider
            ChangeNotifierProvider(create: (_) => DFSProvider()), // ✅ DFS ke liye
            ChangeNotifierProvider(create: (_) => LinearSearchProvider()),
            ChangeNotifierProvider(create: (_) => BinarySearchProvider()),
            ChangeNotifierProvider(create: (_) => InsertionSortProvider()),
            ChangeNotifierProvider(create: (_) => SelectionSortProvider()),
            ChangeNotifierProvider(create: (_) => QuickSortProvider()),
            ChangeNotifierProvider(create: (_) => BubbleSortProvider()),
            ChangeNotifierProvider(create: (_) => MergeSortProvider()),
            ChangeNotifierProvider(create: (_) => BFSDFSProvider()),

          ],
          child: const Home(),
        ),
      ),
    );
  }
}
