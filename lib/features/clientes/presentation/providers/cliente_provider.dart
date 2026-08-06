import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/core/entities/cliente.dart';
import 'package:reparaciones_moka/core/providers/core_dependencies.dart';
import 'package:reparaciones_moka/features/clientes/data/models/cliente_create_request.dart';

class ClientesState {
  final List<Cliente> clientes;
  final bool isLoading;
  final String? error;

  const ClientesState({
    this.clientes = const [],
    this.isLoading = false,
    this.error,
  });

  ClientesState copyWith({
    List<Cliente>? clientes,
    bool? isLoading,
    String? error,
  }) {
    return ClientesState(
      clientes: clientes ?? this.clientes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ClientesNotifier extends Notifier<ClientesState> {
  @override
  ClientesState build() {
    return const ClientesState();
  }

  Future<void> loadClientes({bool forceRefresh = false}) async {
    if (state.isLoading) return;

    if (!forceRefresh && state.clientes.isNotEmpty) return;

    try {
      state = state.copyWith(isLoading: true, error: null);

      final clientes = await ref.read(getClienteUseCaseProvider).execute();

      state = state.copyWith(clientes: clientes, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> createCliente(ClienteCreateRequest cliente) async {
    try{
      state= state.copyWith(
        isLoading: true,
        error: null
      );

      final useCase = ref.read(createClienteUseCaseProvider);
      final response = await useCase.execute(cliente);

      state = state.copyWith(
        isLoading: false,
        clientes: [...state.clientes, response]
      );
    }catch(e){
      state = state.copyWith(
        isLoading: false,
        error: e.toString()
      );
    }
  }
}

final clientesProvider = NotifierProvider<ClientesNotifier, ClientesState>(
  ClientesNotifier.new,
);
