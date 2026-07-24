import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/auth/data/repositories/auth_repository.dart';
import 'package:reparaciones_moka/features/auth/data/services/auth_service.dart';
import 'package:reparaciones_moka/features/auth/data/storage/session_storage.dart';
import 'package:reparaciones_moka/features/auth/domain/auth_use_case.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000',
    ),
  );
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    ref.read(dioProvider),
  );
});

final sessionStorageProvider = Provider<SessionStorage>((ref) {
  return SessionStorage();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(authServiceProvider),
    ref.read(sessionStorageProvider)
  );
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(
    ref.read(authRepositoryProvider),
  );
});