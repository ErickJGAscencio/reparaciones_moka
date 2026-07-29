import 'package:dio/dio.dart';
import 'package:reparaciones_moka/core/models/tipo_equipo_model.dart';

class TiposEquipoService {
  final Dio dio;

  TiposEquipoService(this.dio);

  Future<List<TipoEquipoModel>> getAll() async {
    final response = await dio.get("/tipo_equipos/");
    return (response.data as List).map((e) => TipoEquipoModel.fromJson(e)).toList();
  }
}