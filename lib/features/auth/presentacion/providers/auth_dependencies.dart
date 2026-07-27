import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/core/providers/core_dependencies.dart';
import 'package:reparaciones_moka/features/auth/data/repositories/auth_repository.dart';
import 'package:reparaciones_moka/features/auth/data/services/auth_service.dart';
import 'package:reparaciones_moka/features/auth/domain/auth_use_case.dart';



final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    ref.read(dioProvider),
  );
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