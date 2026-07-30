import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reparaciones_moka/core/auth/user_session.dart';
import 'package:reparaciones_moka/features/auth/presentacion/providers/auth_provider.dart';

class AppDrawer extends ConsumerStatefulWidget  {
  const AppDrawer({super.key});
  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {

  @override
  Widget build(BuildContext context) {
    UserSession session = ref.read(authProvider).session as UserSession;
    String  rol =  session.rol.name == "admin" ? "Administrador" : "Tecnico";

    return Drawer(
      backgroundColor: Color(0xFF2F775A),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
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
                  Text(session.nombre, style: TextStyle(color: Colors.white, fontSize: 18)),

                  SizedBox(height: 4),
                  Text(
                    rol,
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
              leading: const Icon(Icons.receipt_long, color: Colors.white),
              title: const Text(
                'Órdenes',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                context.go('/orders');
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
                context.go('/customers');
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

            const Divider(thickness: 0.5),
            
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

            if(session.rol.name == "admin")
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
              leading: const Icon(Icons.power, color: Colors.white),
              title: const Text(
                'Accesorios',
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

            const Divider(thickness: 0.5),

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
