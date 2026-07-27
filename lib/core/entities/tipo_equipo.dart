class TipoEquipo {
  final int id;
  final String nombre;

  const TipoEquipo({required this.id, required this.nombre});

  factory TipoEquipo.fromJson(Map<String, dynamic> json) {
    return TipoEquipo(id: json["id"], nombre: json["nombre"]);
  }
}
