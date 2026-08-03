import 'package:dio/dio.dart';
import 'package:reparaciones_moka/features/auth/data/storage/session_storage.dart';
import 'package:reparaciones_moka/features/ordenes/data/models/orden_create_request.dart';
import 'package:reparaciones_moka/features/ordenes/data/models/orden_model.dart';

class OrdenService {
  final Dio dio;
  final SessionStorage sessionStorage;

  OrdenService(this.dio, this.sessionStorage);

  Future<List<OrdenModel>> getOrdenes() async {
    final response = await dio.get("/ordenes/");
    return (response.data as List).map((json) => OrdenModel.fromJson(json)).toList();
  }

  Future<OrdenModel> getOrdenById(int id) async {
    final response = await dio.get("/ordenes/$id");
    return OrdenModel.fromJson(response.data);
  }

  Future<OrdenModel> createOrden(OrdenCreateRequest request) async {
    final json = request.toJson();
    final response = await dio.post("/ordenes/crear", data: json);
    return OrdenModel.fromJson(response.data);
  }
  
}
