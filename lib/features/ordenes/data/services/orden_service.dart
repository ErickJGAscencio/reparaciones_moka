import 'package:dio/dio.dart';
import 'package:reparaciones_moka/features/auth/data/storage/session_storage.dart';
import 'package:reparaciones_moka/features/ordenes/data/models/orden_model.dart';
class OrdenService {
  final Dio dio;
  final SessionStorage sessionStorage;

  OrdenService(this.dio, this.sessionStorage);

  Future<List<OrdenModel>> getOrdenes() async {
    final session = await sessionStorage.loadSession();
    
    if(session == null) throw Exception("No hay sesión activa");

    dio.options.headers["Authorization"] = "Bearer ${session.token}";

    final response = await dio.get("/ordenes/");
    return (response.data as List).map((json) => OrdenModel.fromJson(json)).toList();
  }
}
