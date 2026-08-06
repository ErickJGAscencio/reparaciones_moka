import 'package:reparaciones_moka/core/entities/cliente.dart';
import 'package:reparaciones_moka/features/clientes/data/models/cliente_create_request.dart';
import 'package:reparaciones_moka/features/clientes/domain/repositories/cliente_repository.dart';

class CreateClienteUsecase {
  final ClienteRepository repository;

  const CreateClienteUsecase(this.repository);

  Future<Cliente> execute(ClienteCreateRequest clienteRequest){
    return repository.createCliente(clienteRequest);
  }

}