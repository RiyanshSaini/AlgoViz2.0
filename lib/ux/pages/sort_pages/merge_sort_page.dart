import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/sort/merge_sort_provider.dart';
import '../../widgets/sort/merge_sort_visualizer.dart';
import '../../widgets/sort/sort_button.dart';
import 'package:flutter/services.dart';


class MergeSortPage extends StatefulWidget {
  const MergeSortPage({super.key});

  @override
  _MergeSortPageState createState() => _MergeSortPageState();
}

class _MergeSortPageState extends State<MergeSortPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MergeSortProvider(),
      child: Scaffold(
        body: SafeArea(
          child: Row( // Use Row for landscape layout
            children: <Widget>[
              Expanded(flex: 3, child: MergeSortTreeVisualizer()),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SortButton<MergeSortProvider>(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
