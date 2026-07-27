import 'package:reparaciones_moka/core/auth/user_session.dart';
import 'package:reparaciones_moka/features/auth/data/storage/session_storage.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService service;
  final SessionStorage sessionStorage;

  AuthRepository(this.service, this.sessionStorage);

  Future<UserSession> login(String username, String password) async {
    final session = await service.login(username, password);
    await sessionStorage.saveSession(session);
    return session;
  }

  Future<void> logout() async {
    sessionStorage.clearSession();
  }

  Future<UserSession?> getCurrentSession() {
    return sessionStorage.loadSession();
  }
}
