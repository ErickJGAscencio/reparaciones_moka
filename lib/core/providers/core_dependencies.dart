import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/auth/data/storage/session_storage.dart';
import 'package:reparaciones_moka/features/clientes/data/repositories/cliente_repository_impl.dart';
import 'package:reparaciones_moka/features/clientes/data/services/cliente_service.dart';
import 'package:reparaciones_moka/features/clientes/domain/repositories/cliente_repository.dart';
import 'package:reparaciones_moka/features/clientes/domain/usecases/get_clientes_usecase.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000',
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async{
        final session = await ref.read(sessionStorageProvider).loadSession();

        if(session != null){
          options.headers["Authorization"] = "Bearer ${session.token}";
        }

        handler.next(options);
      }
    )
  );

  return dio;
});

final sessionStorageProvider = Provider<SessionStorage>((ref) {
  return SessionStorage();
});

// Clientes
final clienteServiceProvider = Provider<ClienteService>((ref) {
  return ClienteService(ref.read(dioProvider));
});

final clienteRepositoryProvider = Provider<ClienteRepository>((ref) {
  return ClienteRepositoryImpl(ref.read(clienteServiceProvider));
});

final getClienteUseCaseProvider = Provider<GetClientesUseCase>((ref) {
  return GetClientesUseCase(ref.read(clienteRepositoryProvider));
});