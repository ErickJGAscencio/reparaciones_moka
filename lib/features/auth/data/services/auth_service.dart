import 'package:dio/dio.dart';
import 'package:reparaciones_moka/core/auth/user_role.dart';
import 'package:reparaciones_moka/core/auth/user_session.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);
  UserRole _parseRole(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'tecnico':
        return UserRole.technician;
      default:
        throw Exception('Rol no soportado: $role');
    }
  }
  Future<UserSession> login(String username, String password) async {
    try {
      final response = await dio.post(
        "/auth/login",
        data: {"username": username, "password": password},
      );

      return UserSession(
        id: response.data["id"],
        nombre: response.data["nombre"],
        username: response.data["username"],
        rol: _parseRole(response.data["rol"]),
        token: response.data["access_token"],
      );
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final mensaje = e.response?.data["detail"] ?? "Error desconocido";
        throw Exception(mensaje);
      } else {
        throw Exception("Error de conexión con el servidor");
      }
    }
  }
}
