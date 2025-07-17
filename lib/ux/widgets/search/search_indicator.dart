
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/search_model.dart';
import '../../../providers/search/search_provider.dart';

class SearchIndicator<T extends SearchProvider> extends StatefulWidget {
  const SearchIndicator({
    super.key,
    required this.parentKey,
  });

  final GlobalKey parentKey;

  @override
  _SearchIndicatorState<T> createState() => _SearchIndicatorState<T>();
}

class _SearchIndicatorState<T extends SearchProvider> extends State<SearchIndicator<T>> {
  var _position = Offset.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateInitialPosition());
  }

  void _calculateInitialPosition() {
    final numbers = Provider.of<T>(context, listen: false).numbers;
    if (numbers.isNotEmpty) {
      setState(() {
        _position = _getIndicatorOffset(numbers[numbers.length ~/ 2]);
      });
    }
  }

  Offset _getIndicatorOffset(SearchModel number) {
    try {
      final renderBox = number.key.currentContext?.findRenderObject() as RenderBox?;
      final parentBox = widget.parentKey.currentContext?.findRenderObject() as RenderBox?;

      if (renderBox == null || parentBox == null) {
        debugPrint("RenderBox or ParentBox is null");
        return Offset.zero;
      }

      // Get the global position of the number widget
      final numberPos = renderBox.localToGlobal(Offset.zero);

      // Get the global position of the parent widget
      final parentPos = parentBox.localToGlobal(Offset.zero);

      // Calculate the offset relative to the parent widget
      final offset = Offset(
        numberPos.dx - parentPos.dx, // Horizontal offset
        numberPos.dy - parentPos.dy, // Vertical offset
      );

      debugPrint("Calculated offset: $offset for number ${number.value}");
      return offset;
    } catch (e) {
      debugPrint("Error computing indicator position: $e");
    }
    return Offset.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (_, searchProvider, child) {
        for (var number in searchProvider.numbers) {
          if (number.key.currentContext == null) {
            debugPrint("⚠️ Warning: Key for number ${number.value} is null or not attached!");
          }
        }

        for (var number in searchProvider.numbers) {
          if (number.state.value == SearchState.search) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _position = _getIndicatorOffset(number);
                });
              }
            });
            break;
          }
        }

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          curve: Curves.ease,
          left: _position.dx,
          top: _position.dy,
          child: Visibility(
            visible: searchProvider.isSearching,
            child: child!,
          ),
        );
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
    );
  }
}