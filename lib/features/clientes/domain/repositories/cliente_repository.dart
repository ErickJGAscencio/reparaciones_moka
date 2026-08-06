import 'package:reparaciones_moka/core/entities/cliente.dart';
import 'package:reparaciones_moka/features/clientes/data/models/cliente_create_request.dart';

abstract class ClienteRepository {
  Future<List<Cliente>> getAll();
  Future<Cliente> createCliente(ClienteCreateRequest request);
}