import 'package:reparaciones_moka/core/entities/tipo_equipo.dart';

class TipoEquipoModel extends TipoEquipo {
  const TipoEquipoModel({required super.id, required super.nombre});

  factory TipoEquipoModel.fromJson(Map<String, dynamic> json) {
    return TipoEquipoModel(id: json["tipo_equipo_id"], nombre: json["nombre"]);
  }
}
