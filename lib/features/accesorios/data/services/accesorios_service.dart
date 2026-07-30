import 'package:dio/dio.dart';
import 'package:reparaciones_moka/features/accesorios/domain/entities/accesorio.dart';
import 'package:reparaciones_moka/features/accesorios/data/models/accesorio_model.dart';

class AccesoriosService {
  final Dio dio;

  AccesoriosService(this.dio);

  Future<List<Accesorio>> getAll() async{
    final response = await dio.get("/tipos_accesorios/");
    return (response.data as List ).map((json) =>AccesorioModel.fromJson(json)).toList();
  }
  
}