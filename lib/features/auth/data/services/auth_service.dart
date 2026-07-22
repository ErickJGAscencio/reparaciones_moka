import 'package:dio/dio.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<String> login(String username, String password) async {
    try {
      final response = await dio.post(
        "/auth/login",
        data: {"username": username, "password": password},
      );

      return response.data["access_token"];
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
