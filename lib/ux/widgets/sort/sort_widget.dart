import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/sort_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/sort_model.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({
    required super.key,
    required this.number,
    required this.index,
    required this.widgetSize,
    required this.containerWidth,
  });

  final SortModel number;
  final int index;
  final double widgetSize;
  final double containerWidth;

  @override
  Widget build(BuildContext context) {
    var _fontSize = 20.0;
    var _borderRadius = 5.0;
    var _borderWidth = 1.0;
    var _borderColor = Colors.black54;

    if (number.state == SortState.sort) {
      _fontSize = 20;
      _borderRadius = 40.0;
      _borderWidth = 2.0;
    } else if (number.state == SortState.sorted) {
      _fontSize = 20;
      _borderRadius = 5.0;
      _borderWidth = 1.0;
      _borderColor = Colors.green;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
      width: widgetSize,
      height: widgetSize,
      decoration: BoxDecoration(
        border: Border.all(
          color: _borderColor,
          width: _borderWidth,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(_borderRadius),
        ),
      ),
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 400),
          curve: Curves.ease,
          style: TextStyle(
            color: number.color,
            fontSize: _fontSize,
          ),
          child: Text(
            number.value.toString(),
          ),
        ),
      ),
    );
  }
}
