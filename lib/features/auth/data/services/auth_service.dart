import 'package:dio/dio.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<String> login(String username, String password) async {
    final response = await dio.post(
      "/auth/login",
      data: {
        "username": username,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return response.data["access_token"]; 
    } else {
      throw Exception("Error al iniciar sesión");
    }
  }
}
