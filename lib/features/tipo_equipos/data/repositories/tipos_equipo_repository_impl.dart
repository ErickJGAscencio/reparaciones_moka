import 'package:reparaciones_moka/core/entities/tipo_equipo.dart';
import 'package:reparaciones_moka/features/tipo_equipos/data/services/tipos_equipo_service.dart';
import 'package:reparaciones_moka/features/tipo_equipos/domain/repositories/tipos_equipo_repository.dart';

class TiposEquipoRepositoryImpl implements TiposEquipoRepository{
  final TiposEquipoService service;

  TiposEquipoRepositoryImpl(this.service);

  @override
  Future<List<TipoEquipo>> getAll(){
    return service.getAll();
  }
}