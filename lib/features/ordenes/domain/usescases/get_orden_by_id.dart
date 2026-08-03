import 'package:reparaciones_moka/features/ordenes/domain/entities/orden.dart';
import 'package:reparaciones_moka/features/ordenes/domain/repositories/orden_repository.dart';

class GetOrdenById {
  final OrdenRepository repository;
  
  GetOrdenById(this.repository);

  Future<Orden> execute(int id) {
    return repository.getOrdenById(id);
  }
}