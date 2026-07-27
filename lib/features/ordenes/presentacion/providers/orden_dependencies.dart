import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/core/providers/core_dependencies.dart';
import 'package:reparaciones_moka/features/ordenes/data/repositories/orden_repository_impl.dart';
import 'package:reparaciones_moka/features/ordenes/data/services/orden_service.dart';
import 'package:reparaciones_moka/features/ordenes/domain/repositories/orden_repository.dart';
import 'package:reparaciones_moka/features/ordenes/domain/usescases/get_ordenes.dart';

final ordenServiceProvider = Provider<OrdenService>((ref) {
  return OrdenService(
    ref.read(dioProvider),
    ref.read(sessionStorageProvider),
  );
});

final ordenRepositoryProvider = Provider<OrdenRepository>((ref) {
  return OrdenRepositoryImpl(
    ref.read(ordenServiceProvider),
  );
});

final getOrdenesUseCaseProvider = Provider<GetOrdenesUseCase>((ref) {
  return GetOrdenesUseCase(
    ref.read(ordenRepositoryProvider),
  );
});