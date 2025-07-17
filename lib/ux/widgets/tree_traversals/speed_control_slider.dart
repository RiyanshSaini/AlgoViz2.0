import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/base_providers.dart';

class SpeedControlSlider<T extends BaseProvider> extends StatelessWidget {
  const SpeedControlSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<T>(context);
    return Column(
      children: [
        Text("Speed: ${provider.executionSpeed.toStringAsFixed(2)} "),
        Slider(
          value: provider.executionSpeed,
          min: 0.1,
          max: 1.0,
          onChanged: (value) => provider.executionSpeed = value,
        ),
      ],
    );
  }
}