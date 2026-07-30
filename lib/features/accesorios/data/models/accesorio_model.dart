import 'package:reparaciones_moka/features/accesorios/domain/entities/accesorio.dart';

class AccesorioModel extends Accesorio {
  const AccesorioModel({required super.id, required super.nombre});

  factory AccesorioModel.fromJson(Map<String, dynamic> json) {
    return AccesorioModel(id: json['accesorio_tipo_id'], nombre: json['nombre']);
  }
}
