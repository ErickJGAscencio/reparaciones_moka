import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/clientes/presentation/providers/cliente_provider.dart';

class ClientesPage extends ConsumerStatefulWidget {
  const ClientesPage({super.key});
  @override
  ConsumerState<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends ConsumerState<ClientesPage> {
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

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text(state.error!));
    }

    if (state.clientes.isEmpty) {
      return const Center(child: Text("No hay clientes"));
    }

    return ListView.builder(
      itemCount: state.clientes.length,
      itemBuilder: (context, index) {
        final cliente = state.clientes[index];
        String id = cliente.id.toString();
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ID: $id', style: TextStyle(color: Colors.blueGrey)),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  cliente.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text('Contacto', style: TextStyle(color: Colors.blueGrey)),
                Text(
                  '${cliente.telefono}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
