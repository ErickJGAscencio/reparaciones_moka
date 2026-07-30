import 'package:reparaciones_moka/features/accesorios/domain/entities/accesorio.dart';

abstract class AccesoriosRepository{
  Future<List<Accesorio>> getAll();
}