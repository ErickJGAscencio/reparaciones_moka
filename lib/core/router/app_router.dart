import 'package:go_router/go_router.dart';
import 'package:reparaciones_moka/features/auth/presentacion/pages/login_page.dart';
import 'package:reparaciones_moka/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/pages/ordenes_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (_,__) => const LoginPage()),
      GoRoute(path: '/dashboard', builder: (_,__) => const DashboardPage()),
      GoRoute(path: '/orders', builder: (_,__) => const OrdenesPage()),
      // GoRoute(path: '/customers'),
      // GoRoute(path: '/settings'),
      // GoRoute(path: '/users')
    ]
  );
}