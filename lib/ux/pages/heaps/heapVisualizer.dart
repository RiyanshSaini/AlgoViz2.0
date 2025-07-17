import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

// Replace your entire HeapVisualizer with this minimal version
class HeapVisualizer extends StatefulWidget {
  @override
  _HeapVisualizerState createState() => _HeapVisualizerState();
}

class _HeapVisualizerState extends State<HeapVisualizer> {
  Artboard? _artboard;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRive();
  }

  Future<void> _loadRive() async {
    try {
      final bytes = await rootBundle.load('assets/rive/heap_visulization/artboard.riv');
      final file = RiveFile.import(bytes);

      if (file != null) {
        setState(() {
          _artboard = file.mainArtboard;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading Rive: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _artboard == null
            ? Text('Failed to load animation')
            : Rive(
          artboard: _artboard!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}