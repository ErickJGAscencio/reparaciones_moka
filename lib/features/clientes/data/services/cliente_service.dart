import 'package:dio/dio.dart';
import 'package:reparaciones_moka/core/models/cliente_model.dart';

class ClienteService {
  final Dio dio;
  
  ClienteService(this.dio);

  Future<List<ClienteModel>> getAll() async {
    final response = await dio.get("/clientes/");
    return (response.data as List).map((e) => ClienteModel.fromJson(e)).toList();
  }
}