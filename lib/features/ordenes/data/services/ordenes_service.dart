import 'package:dio/dio.dart';

class OrdenesService {
  final Dio dio;

  OrdenesService(this.dio);

  Future<List<Map<String, dynamic>>> getOrdenes(String token) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    final response = await dio.get("/ordenes/");
    return List<Map<String, dynamic>>.from(response.data);
  }
}
