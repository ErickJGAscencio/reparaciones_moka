import 'package:flutter/material.dart';

class SearchSelectorSheet<T> extends StatelessWidget {
  final String title;
  final Future<List<T>> Function(String query) onSearch;
  final Widget Function(T item) itemBuilder;

  const SearchSelectorSheet({
    super.key,
    required this.title,
    required this.onSearch,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .80,
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Divider(height: 1),

          const Expanded(
            child: Center(
              child: Text("Aquí irá la búsqueda"),
            ),
          ),
        ],
      ),
    );
  }
}