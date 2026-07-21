import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService service;

  AuthRepository(this.service);

  Future<bool> login(String username, String password) async {
    final token = await service.login(username, password);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);

    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}
