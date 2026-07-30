import 'package:reparaciones_moka/features/tecnicos/domain/entities/user.dart';
import 'package:reparaciones_moka/features/tecnicos/domain/repositories/user_repository.dart';

class GetUsersUsecase {
  final UserRepository repository;

  const GetUsersUsecase(this.repository);

  Future<List<User>> execute(){
    return repository.getAll();
  }
}