import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/core/providers/core_dependencies.dart';
import 'package:reparaciones_moka/features/ordenes/domain/entities/orden.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/orden_dependencies.dart';

class OrdenesState {
  final List<Orden> ordenes;
  final bool isLoading;
  final String? error;

  const OrdenesState({
    this.ordenes = const [],
    this.isLoading = false,
    this.error,
  });

  OrdenesState copyWith({
    List<Orden>? ordenes,
    bool? isLoading,
    String? error,
  }) {
    return OrdenesState(
      ordenes: ordenes ?? this.ordenes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class OrdenesNotifier extends Notifier<OrdenesState> {
  @override
  OrdenesState build() {
    return const OrdenesState();
  }

  Future<void> loadOrdenes() async {
    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      final useCase = ref.read(getOrdenesUseCaseProvider);

      final ordenes = await useCase.execute();

      state = state.copyWith(
        ordenes: ordenes,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> createOrden(Orden orden) async { 
    try{
      state = state.copyWith(
        isLoading: true,
        error: null
      );

      // final useCase = ref.read(getUsersUseCaseProvider)
    }catch(e){
      state = state.copyWith(
        isLoading: false,error: e.toString()
      );
    }
  }
}

final ordenesProvider =
    NotifierProvider<OrdenesNotifier, OrdenesState>(
  OrdenesNotifier.new,
);

