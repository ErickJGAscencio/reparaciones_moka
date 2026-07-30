// LOS USUARIOS SON LAS ENTIDADES PRINCIPALES EN EL SISTEMA
// ELLOS SON CONSIDERADOS TECNICOS
class User {
  final int id;
  final String nombre;
  final String username;
  final int rolId;

  const User({
    required this.id,
    required this.nombre,
    required this.username,
    required this.rolId
  });
}