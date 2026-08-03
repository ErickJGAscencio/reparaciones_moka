// LOS USUARIOS SON LAS ENTIDADES PRINCIPALES EN EL SISTEMA
// ELLOS SON CONSIDERADOS TECNICOS
class User {
  final int id;
  final String nombre;
  final String username;
  final Rol rol;

  const User({
    required this.id,
    required this.nombre,
    required this.username,
    required this.rol
  });
}

class Rol{
  final int id;
  final String nombre;

  const Rol({
    required this.id,
    required this.nombre
  });
}

class RolModel extends Rol {
  const RolModel({
    required super.id,
    required super.nombre
  });

  factory RolModel.fromJson(Map<String, dynamic> json) {
    return RolModel(
      id: json['rol_id'],
      nombre: json['nombre'],
    );
  }
}