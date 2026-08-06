import 'package:dio/dio.dart';
import 'package:reparaciones_moka/core/models/cliente_model.dart';
import 'package:reparaciones_moka/features/clientes/data/models/cliente_create_request.dart';

class ClienteService {
  final Dio dio;

  ClienteService(this.dio);

  Future<List<ClienteModel>> getAll() async {
    final response = await dio.get("/clientes/");
    return (response.data as List)
        .map((e) => ClienteModel.fromJson(e))
        .toList();
  }

  Future<ClienteModel> createCliente(ClienteCreateRequest request) async {
    final json = request.toJson();
    final response = await dio.post("/clientes/crear", data: json);
    return ClienteModel.fromJson(response.data);
  }
}
