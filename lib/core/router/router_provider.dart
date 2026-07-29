import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reparaciones_moka/core/navigation/app_shell.dart';
import 'package:reparaciones_moka/features/auth/presentacion/pages/login_page.dart';
import 'package:reparaciones_moka/features/auth/presentacion/pages/splash_page.dart';
import 'package:reparaciones_moka/features/clientes/presentation/pages/clientes_page.dart';
// import 'package:reparaciones_moka/features/auth/presentacion/providers/auth_provider.dart';
import 'package:reparaciones_moka/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/pages/ordenes_page.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    // redirect: (context, state) {
    //   final authState = ref.read(authProvider);

    //   final isLoggedIn = authState.session != null;
    //   final isLoginRoute = state.matchedLocation == '/login';

    //   if (!isLoggedIn && !isLoginRoute) {
    //     return '/login';
    //   }

    //   if (isLoggedIn && isLoginRoute) {
    //     return '/dashboard';
    //   }

    //   return null;
    // },
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (_, __) => const SplashPage(),
      ),
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
          StatefulShellBranch(
            initialLocation: '/dashboard',
            routes: [
              GoRoute(
                path: '/dashboard',
                name: 'dashboard',
                builder: (_, __) => const DashboardPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: '/orders',
            routes: [
              GoRoute(
                path: '/orders',
                name: 'orders',
                builder: (_, __) => const OrdenesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: '/customers',
            routes: [
              GoRoute(
                path: '/customers',
                name: 'customers',
                builder: (_, __) => const ClientesPage(),
              ),
            ],
          ),
          // StatefulShellBranch(
          //   routes: [
          //     // GoRoute(path: '/settings'),
          //     // GoRoute(path: '/users')
          //   ],
          // ),
        ],
      ),
    ],
  );
});
