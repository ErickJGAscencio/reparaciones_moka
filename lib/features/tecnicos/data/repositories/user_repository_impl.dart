import 'package:reparaciones_moka/features/tecnicos/data/service/users_service.dart';
import 'package:reparaciones_moka/features/tecnicos/domain/entities/user.dart';
import 'package:reparaciones_moka/features/tecnicos/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  final UsersService service;

  const UserRepositoryImpl(this.service);

  @override
  Future<List<User>> getAll(){
    return service.getAll();
  }
}