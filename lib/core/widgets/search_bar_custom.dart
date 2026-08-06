import 'package:flutter/material.dart';

class SearchBarCustom extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final VoidCallback? onClear;
  final Widget? suffixIcon;
  const SearchBarCustom({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.controller,
    this.onClear,
    this.suffixIcon,
  });

  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Buscar ${widget.hintText}...",
          prefixIcon: const Icon(Icons.search),
          suffixIcon: widget.suffixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        ),
        onChanged: (value) {
          widget.onChanged(value);
        },
      ),
    );
  }
}
