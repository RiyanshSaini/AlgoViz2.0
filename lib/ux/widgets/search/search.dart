
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../providers/search/search_provider.dart';

class Search<T extends SearchProvider> extends StatefulWidget {
  const Search({
    super.key, // Mark `key` as nullable using `Key?`
  });

  @override
  _SearchState<T> createState() => _SearchState<T>();
}

class _SearchState<T extends SearchProvider> extends State<Search<T>> {
  final searchController = TextEditingController();

  void _search() {
    try {
      final val = int.parse(searchController.text);
      Provider.of<T>(context, listen: false).search(value: val);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 100,
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Value',
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly, // Use updated formatter
            ],
            keyboardType: TextInputType.number,
          ),
        ),
        Selector<T, bool>(
          selector: (_, provider) => provider.isSearching,
          builder: (_, isSearching, child) {
            return ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (states) => states.contains(WidgetState.disabled)
                      ? Colors.blueGrey
                      : Colors.blue,
                ),
              ),
              onPressed: isSearching ? null : _search,
              child: child,
            );
          },
          child: const Text('Search', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
