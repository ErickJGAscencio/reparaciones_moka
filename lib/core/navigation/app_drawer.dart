import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF2F775A),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'MOKA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('Luis montiel', style: TextStyle(color: Colors.white, fontSize: 18)),

                  SizedBox(height: 4),
                  Text(
                    'Administrador / Técnico',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.dashboard, color: Colors.white),
              title: const Text(
                'Inicio',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                context.go('/dashboard');
                Navigator.of(context).pop();
              },
            ),

            ListTile(
              leading: const Icon(Icons.group, color: Colors.white),
              title: const Text(
                'Clientes',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                context.go('/clientes');
                Navigator.of(context).pop();
              },
            ),
            

            ListTile(
              leading: const Icon(Icons.receipt_long, color: Colors.white),
              title: const Text(
                'Órdenes',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                context.go('/ordenes');
                Navigator.of(context).pop();
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.history_outlined, color: Colors.white),
              title: const Text(
                'Historial',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // context.go('/dashboard');
                Navigator.of(context).pop();
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.security, color: Colors.white),
              title: const Text(
                'Roles y permisos',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // context.go('/dashboard');
                Navigator.of(context).pop();
              },
            ),
            
            const Divider(),

            ListTile(
              leading: const Icon(Icons.people, color: Colors.white),
              title: const Text(
                'Usuarios',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                context.go('/users');
                Navigator.of(context).pop();
              },
            ),

            ListTile(
              leading: const Icon(Icons.receipt, color: Colors.white),
              title: const Text(
                'Notas y recepción',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // context.go('/dashboard');
                Navigator.of(context).pop();
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.payments, color: Colors.white),
              title: const Text(
                'Facturación',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                context.go('/dashboard');
                Navigator.of(context).pop();
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text(
                'Configuración',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                context.go('/settings');
                Navigator.of(context).pop();
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text(
                'Cerrar sesión',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pop();
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
