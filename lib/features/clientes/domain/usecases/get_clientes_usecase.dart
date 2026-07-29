import 'package:reparaciones_moka/core/entities/cliente.dart';
import 'package:reparaciones_moka/features/clientes/domain/repositories/cliente_repository.dart';

class GetClientesUseCase {
  final ClienteRepository repository;

  GetClientesUseCase(this.repository);

  Future<List<Cliente>> execute(){
    return repository.getAll();
  }

}