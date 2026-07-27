import 'package:reparaciones_moka/core/entities/estado_equipo.dart';

class EstadoEquipoModel extends EstadoEquipo {
  const EstadoEquipoModel({required super.id, required super.nombre});

  factory EstadoEquipoModel.fromJson(Map<String, dynamic> json) {
    return EstadoEquipoModel(id: json["estado_equipo_id"], nombre: json["nombre"]);
  }
}
