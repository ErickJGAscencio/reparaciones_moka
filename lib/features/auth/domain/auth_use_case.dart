import 'package:reparaciones_moka/core/auth/user_session.dart';
import 'package:reparaciones_moka/features/auth/data/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserSession> execute(String username, String password) {
    return repository.login(username, password);
  }
}
