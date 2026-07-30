import 'package:reparaciones_moka/features/accesorios/data/services/accesorios_service.dart';
import 'package:reparaciones_moka/features/accesorios/domain/entities/accesorio.dart';
import 'package:reparaciones_moka/features/accesorios/domain/repositories/accesorios_repository.dart';

class AccesoriosRepositoryImpl implements AccesoriosRepository{
  final AccesoriosService servicio;

  AccesoriosRepositoryImpl(this.servicio);

  @override
  Future<List<Accesorio>> getAll() async{
    return await servicio.getAll();
  }  
}