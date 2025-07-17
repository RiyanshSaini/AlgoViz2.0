
import 'package:flutter/material.dart';

import '../../../models/search_model.dart';



class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.number});

  final SearchModel number;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SearchState>(
      valueListenable: number.state,
      builder: (context, state, child) {
        debugPrint("SearchWidget key: ${number.key}");
        double fontSize = 20;
        if (state == SearchState.search) {
          fontSize = 30;
        } else if (state == SearchState.found) {
          fontSize = 35;
        } else if (state == SearchState.searched) {
          fontSize = 20;
        }
        return AnimatedContainer(
          key: number.key, // This key will be used for offset calculation
          duration: const Duration(milliseconds: 900),
          curve: Curves.ease,
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            border: (state == SearchState.found)
                ? Border.all(color: Colors.green)
                : null,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: CustomTextStyle(
            fontSize: fontSize,
            number: number,
            numberValue: number.value.toString(),
            state: state,
          ),
        );
      },
    );
  }
}

class CustomTextStyle extends StatelessWidget {
  const CustomTextStyle({
    Key? key,
    required this.fontSize,
    required this.number,
    required this.numberValue,
    required this.state,
  }) : super(key: key);

  final double fontSize;
  final SearchModel number;
  final String numberValue;
  final SearchState state;

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
      style: TextStyle(
        fontSize: fontSize,
        decoration: (state == SearchState.discard)
            ? TextDecoration.lineThrough
            : TextDecoration.none,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 1.7,
        color: number.color,
      ),
      child: Center(
        child: Text(numberValue),
      ),
    );
  }
}
