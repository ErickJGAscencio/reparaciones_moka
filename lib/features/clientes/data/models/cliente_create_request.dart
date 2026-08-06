import 'package:reparaciones_moka/features/clientes/domain/entities/cliente_draft.dart';

class ClienteCreateRequest {
  final String nombre;
  final String telefono;
  final String correo;
  final String direccion;
  final String notas;

  const ClienteCreateRequest({
    required this.nombre,
    required this.telefono,
    required this.correo,
    required this.direccion,
    required this.notas,
  });

  factory ClienteCreateRequest.fromDraft(ClienteDraft draft) {
    return ClienteCreateRequest(
      nombre: draft.nombre,
      telefono: draft.telefono,
      correo: draft.correo,
      direccion: draft.direccion ?? "",
      notas: draft.notas ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "telefono": telefono,
      "correo": correo,
      "direccion": direccion,
      "notas": notas,
    };
  }
}
