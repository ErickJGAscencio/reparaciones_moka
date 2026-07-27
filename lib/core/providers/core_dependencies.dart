import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/auth/data/storage/session_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000',
    ),
  );
});

final sessionStorageProvider = Provider<SessionStorage>((ref) {
  return SessionStorage();
});
