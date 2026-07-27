import '../entities/orden.dart';

abstract class OrdenRepository {
  Future<List<Orden>> getOrdenes();
}