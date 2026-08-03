import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/ordenes/data/models/orden_create_request.dart';
import 'package:reparaciones_moka/features/ordenes/domain/entities/orden.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/orden_dependencies.dart';

class OrdenesState {
  final List<Orden> ordenes;
  final Orden? selectedOrden;
  final bool isLoading;
  final String? error;

  const OrdenesState({
    this.ordenes = const [],
    this.selectedOrden = null,
    this.isLoading = false,
    this.error,
  });

  OrdenesState copyWith({
    List<Orden>? ordenes,
    Orden? selectedOrden,
    bool? isLoading,
    String? error,
  }) {
    return OrdenesState(
      ordenes: ordenes ?? this.ordenes,
      selectedOrden: selectedOrden ?? this.selectedOrden,
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
  
  Future<void> loadOrdenById(int id) async {
    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      final useCase = ref.read(getOrdenByIdUseCaseProvider);

      final orden = await useCase.execute(id);

      state = state.copyWith(
        selectedOrden: orden,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> createOrden(OrdenCreateRequest orden) async { 
    try{
      state = state.copyWith(
        isLoading: true,
        error: null
      );

      final useCase = ref.read(createOrdenUseCaseProvider);
      final response = await useCase.execute(orden);

      state = state.copyWith(
        isLoading: false,
        ordenes: [...state.ordenes, response]
      );
    }catch(e){
      state = state.copyWith(
        isLoading: false,
        error: e.toString()
      );
    }
  }
}

final ordenesProvider =
    NotifierProvider<OrdenesNotifier, OrdenesState>(
  OrdenesNotifier.new,
);

