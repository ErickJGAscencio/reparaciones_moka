//Contenedor de la aplicación despues del Login
//Todas las pantallas principales vivirán dentro del shellp

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reparaciones_moka/core/navigation/app_drawer.dart';
import 'package:reparaciones_moka/core/navigation/bottom_navigation.dart';
import 'package:reparaciones_moka/core/navigation/navigation_items.dart';
import 'package:reparaciones_moka/features/clientes/presentation/widgets/cliente_form_bottom_sheet.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/widgets/orden_form_bottom_sheet.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitles[navigationShell.currentIndex],
          style: TextStyle(
            color: const Color(0xFF326253),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: navigationShell,
      bottomNavigationBar: BottomNavigation(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(index);
        },
        items: navigationItems,
      ),
      floatingActionButton: _buildFab(context),
    );
  }

  Widget? _buildFab(BuildContext context) {
    switch (navigationShell.currentIndex) {
      case 0:
        return null; //Dashboard
      case 1:
        return FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              // isDismissible: false,
              enableDrag: true,
              useSafeArea: true,
              showDragHandle: true,
              builder: (_) => const OrdenFormBottomSheet(),
            );
          },
          child: const Icon(Icons.add),
        );
      case 2:
        return FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              // isDismissible: false,
              enableDrag: true,
              useSafeArea: true,
              showDragHandle: true,
              builder: (_) => const ClienteFormBottomSheet(),
            );
          },
          child: const Icon(Icons.person_add),
        );
      default:
        return null;
    }
  }
}
