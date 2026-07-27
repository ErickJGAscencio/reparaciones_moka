import 'package:reparaciones_moka/core/entities/estado_reparacion.dart';

class EstadoReparacionModel extends EstadoReparacion {
  const EstadoReparacionModel({required super.id, required super.nombre});

  factory EstadoReparacionModel.fromJson(Map<String, dynamic> json) {
    return EstadoReparacionModel(id: json["estado_reparacion_id"], nombre: json["nombre"]);
  }
}
