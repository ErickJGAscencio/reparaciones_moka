import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/clientes/presentation/providers/cliente_provider.dart';

class ClienteSelectorBottomSheet extends ConsumerStatefulWidget {
  const ClienteSelectorBottomSheet({super.key});

  @override
  ConsumerState<ClienteSelectorBottomSheet> createState() =>
      _ClienteSelectorBottomSheetState();
}

class _ClienteSelectorBottomSheetState
    extends ConsumerState<ClienteSelectorBottomSheet> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(clientesProvider.notifier).loadClientes();
    });
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(clientesProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height * .75,

      child: Column(
        children: [

          const SizedBox(height: 16),

          const Text(
            "Seleccionar cliente",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Divider(),

          Expanded(
            child: Builder(
              builder: (_) {

                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.error != null) {
                  return Center(
                    child: Text(state.error!),
                  );
                }

                if (state.clientes.isEmpty) {
                  return const Center(
                    child: Text("No hay clientes"),
                  );
                }

                return ListView.builder(
                  itemCount: state.clientes.length,
                  itemBuilder: (_, index) {

                    final cliente = state.clientes[index];

                    return ListTile(
                      onTap: () {
                        Navigator.pop(context, cliente);
                      },
                      title: Text(cliente.nombre),
                      subtitle: Text(cliente.telefono),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}