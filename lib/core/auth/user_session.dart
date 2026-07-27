import 'package:reparaciones_moka/core/entities/user_role.dart';

class UserSession {
  final int id;
  final String nombre;
  final String username;
  final UserRole rol;
  final String token;

  const UserSession({
    required this.id,
    required this.nombre,
    required this.username,
    required this.rol,
    required this.token,
  });
  
  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      id: json['id'],
      nombre: json['nombre'],
      username: json['username'],
      rol: UserRole.fromJson(json['rol']),
      token: json['token'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'username': username,
      'rol': rol.toJson(),
      'token': token,
    };
  }
}
