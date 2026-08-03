import 'package:reparaciones_moka/features/ordenes/data/models/orden_create_request.dart';
import 'package:reparaciones_moka/features/ordenes/data/services/orden_service.dart';
import 'package:reparaciones_moka/features/ordenes/domain/entities/orden.dart';
import 'package:reparaciones_moka/features/ordenes/domain/repositories/orden_repository.dart';

class OrdenRepositoryImpl implements OrdenRepository {
  final OrdenService service;

  OrdenRepositoryImpl(this.service);

  @override
  Future<List<Orden>> getOrdenes() async {
    return await service.getOrdenes();
  }

  @override
  Future<Orden> createOrden(OrdenCreateRequest request) async {
    return await service.createOrden(request);
  }

  @override
  Future<Orden> getOrdenById(int id) async {
    return await service.getOrdenById(id);
  }
}