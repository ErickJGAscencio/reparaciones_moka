import 'package:go_router/go_router.dart';
import 'package:reparaciones_moka/features/auth/presentacion/pages/login_page.dart';
import 'package:reparaciones_moka/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/pages/ordenes_screen.dart';
import 'package:reparaciones_moka/core/navigation/app_shell.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (_, __) => const LoginPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(initialLocation: '/dashboard',
            routes: [
              GoRoute(
                path: '/dashboard',
                name: 'dashboard',
                builder: (_, __) => const DashboardPage(),
              ),
            ],
          ),
          StatefulShellBranch(initialLocation: '/orders',
            routes: [
              GoRoute(
                path: '/orders',
                name: 'orders',
                builder: (_, __) => const OrdenesPage(),
              ),
            ],
          ),
          // StatefulShellBranch(
          //   routes: [
          //     // GoRoute(path: '/customers'),
          //     // GoRoute(path: '/settings'),
          //     // GoRoute(path: '/users')
          //   ],
          // ),
        ],
      ),
    ],
  );
}
