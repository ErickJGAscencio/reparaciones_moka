import 'package:reparaciones_moka/features/ordenes/data/models/orden_create_request.dart';
import 'package:reparaciones_moka/features/ordenes/domain/entities/orden.dart';
import 'package:reparaciones_moka/features/ordenes/domain/repositories/orden_repository.dart';

class CreateOrdenUseCase {
  final OrdenRepository repository;

  CreateOrdenUseCase(this.repository);

  Future<Orden> execute(OrdenCreateRequest ordenRequest) {
    return repository.createOrden(ordenRequest);
  }
}