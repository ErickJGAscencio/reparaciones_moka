import 'package:reparaciones_moka/core/entities/cliente.dart';
import 'package:reparaciones_moka/features/clientes/data/services/cliente_service.dart';
import 'package:reparaciones_moka/features/clientes/domain/repositories/cliente_repository.dart';

class ClienteRepositoryImpl implements ClienteRepository{
  final ClienteService service;

  ClienteRepositoryImpl(this.service);

  @override
  Future<List<Cliente>> getAll(){
    return service.getAll();
  }
}