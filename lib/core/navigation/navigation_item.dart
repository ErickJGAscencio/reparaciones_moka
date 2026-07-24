import 'package:flutter/material.dart';

class NavigationItem {
  final String label;
  final String title;
  final IconData icon;
  final IconData selectedIcon;

  const NavigationItem({
    required this.label,
    required this.title,
    required this.icon,
    required this.selectedIcon,
  });
}