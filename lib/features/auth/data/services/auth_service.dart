import 'package:dio/dio.dart';
import 'package:reparaciones_moka/core/auth/user_session.dart';
import 'package:reparaciones_moka/core/entities/user_role.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<UserSession> login(String username, String password) async {
    try {
      final response = await dio.post(
        "/auth/login",
        data: {"username": username, "password": password},
      );

      final userData = response.data["user"];

      final token = response.data["access_token"];
      final id = userData["user_id"];
      final nombre = userData["nombre"];
      final usernames = userData["username"];
      final rol = UserRole(id: userData["rol_id"], name: userData["rol"]);

      return UserSession(
        token: token,
        id: id,
        nombre: nombre,
        username: usernames,
        rol: rol,
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
