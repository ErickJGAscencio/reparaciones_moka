class ClienteDraft {
  final String nombre;
  final String telefono;
  final String correo;
  final String? direccion;
  final String? notas;

  const ClienteDraft({
    this.nombre = "",
    this.telefono = "",
    this.correo = "",
    this.direccion,
    this.notas,
  });

  ClienteDraft copyWith({
    String? nombre,
    String? telefono,
    String? correo,
    String? direccion,
    String? notas,
  }) {
    return ClienteDraft(
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      correo: correo ?? this.correo,
      direccion: direccion ?? this.direccion,
      notas: notas ?? this.notas,
    );
  }
}
