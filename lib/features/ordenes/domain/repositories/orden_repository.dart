import 'package:reparaciones_moka/features/ordenes/data/models/orden_create_request.dart';

import '../entities/orden.dart';

abstract class OrdenRepository {
  Future<List<Orden>> getOrdenes();
  Future<Orden> createOrden(OrdenCreateRequest request);
  Future<Orden> getOrdenById(int id);
}