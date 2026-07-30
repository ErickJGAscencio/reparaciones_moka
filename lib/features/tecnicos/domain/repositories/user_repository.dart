import 'package:reparaciones_moka/features/tecnicos/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getAll();
}