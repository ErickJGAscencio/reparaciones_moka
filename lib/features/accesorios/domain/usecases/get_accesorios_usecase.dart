import 'package:reparaciones_moka/features/accesorios/domain/entities/accesorio.dart';
import 'package:reparaciones_moka/features/accesorios/domain/repositories/accesorios_repository.dart';

class GetAccesoriosUsecase {
  final AccesoriosRepository repository;

  GetAccesoriosUsecase(this.repository);

  Future<List<Accesorio>> execute() {
    return repository.getAll();
  }
}