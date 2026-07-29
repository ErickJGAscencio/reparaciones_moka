import 'package:reparaciones_moka/core/entities/tipo_equipo.dart';
import 'package:reparaciones_moka/features/tipo_equipos/domain/repositories/tipos_equipo_repository.dart';

class GetTiposEquipoUsecase {
  final TiposEquipoRepository repository;

  GetTiposEquipoUsecase(this.repository);

  Future<List<TipoEquipo>> execute(){
    return repository.getAll();
  }
}