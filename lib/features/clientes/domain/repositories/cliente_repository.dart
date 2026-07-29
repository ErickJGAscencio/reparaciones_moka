import 'package:reparaciones_moka/core/entities/cliente.dart';

abstract class ClienteRepository {
  Future<List<Cliente>> getAll();
}