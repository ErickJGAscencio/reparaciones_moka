import 'package:flutter/material.dart';
import 'package:reparaciones_moka/core/navigation/navigation_item.dart';

const navigationItems = [
  NavigationItem(
    label: 'Inicio',
    title: 'Inicio',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
  ),
  NavigationItem(
    label: 'Órdenes',
    title: 'Órdenes',
    icon: Icons.receipt_long_outlined,
    selectedIcon: Icons.receipt_long,
  ),
  NavigationItem(
    label: 'Clientes',
    title: 'Clientes',
    icon: Icons.group,
    selectedIcon: Icons.group_outlined,
  ),
];

const appBarTitles = ['Inicio', 'Órdenes', 'Clientes'];
