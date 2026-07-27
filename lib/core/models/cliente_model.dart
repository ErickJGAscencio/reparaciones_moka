import 'package:reparaciones_moka/core/entities/cliente.dart';

class ClienteModel extends Cliente{
  const ClienteModel({
    required super.id,
    required super.nombre,
    required super.correo,
    required super.direccion,
    required super.telefono,
    required super.notas,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      id: json["cliente_id"],
      nombre: json["nombre"],
      telefono: json["telefono"],
      correo: json["correo"],
      direccion: json["direccion"],
      notas: json["notas"],
    );
  }
}