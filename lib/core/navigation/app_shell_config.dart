import 'package:flutter/material.dart';

class AppShellConfig {
  final String title;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const AppShellConfig({
    required this.title, 
    this.floatingActionButton,
    this.actions,
  });
}