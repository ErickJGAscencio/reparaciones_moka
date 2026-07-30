import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/core/providers/core_dependencies.dart';
import 'package:reparaciones_moka/features/accesorios/domain/entities/accesorio.dart';

class AccesoriosState {
  final List<Accesorio> accesorios;
  final bool isLoading;
  final String? error;

  const AccesoriosState({
    this.accesorios = const [],
    this.isLoading = false,
    this.error,
  });

  AccesoriosState copyWith({
    List<Accesorio>? accesorios,
    bool? isLoading,
    String? error,
  }) {
    return AccesoriosState(
      accesorios: accesorios ?? this.accesorios,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AccesoriosNotifier extends Notifier<AccesoriosState> {
  @override
  AccesoriosState build() {
    return const AccesoriosState();
  }

  Future<void> loadAccesorios() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final useCase = ref.read(getAccesoriosUseCaseProvider);

      final accesorios = await useCase.execute();

      state = state.copyWith(accesorios: accesorios, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final accesoriosProvider =
    NotifierProvider<AccesoriosNotifier, AccesoriosState>(
      AccesoriosNotifier.new,
    );
