import 'package:reparaciones_moka/core/entities/tipo_equipo.dart';

abstract class TiposEquipoRepository {
  Future<List<TipoEquipo>> getAll();
}