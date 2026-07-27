import 'package:flutter/material.dart';
import 'search_selector_sheet.dart';

Future<T?> showSearchSelector<T>({
  required BuildContext context,
  required String title,
  required Future<List<T>> Function(String query) onSearch,
  required Widget Function(T item) itemBuilder,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => SearchSelectorSheet<T>(
      title: title,
      onSearch: onSearch,
      itemBuilder: itemBuilder,
    ),
  );
}