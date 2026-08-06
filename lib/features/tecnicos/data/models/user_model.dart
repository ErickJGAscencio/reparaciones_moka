import 'package:reparaciones_moka/features/tecnicos/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.nombre,
    required super.username,
    required super.rol,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final rol = json['rol'];
    return UserModel(
      id: json['user_id'],
      nombre: json['nombre'],
      username: json['username'],
      rol: RolModel(id: rol['rol_id'], nombre: rol["nombre"]),
    ); 
  }
}
