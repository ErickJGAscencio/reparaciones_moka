import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/core/entities/cliente.dart';
import 'package:reparaciones_moka/core/widgets/search_bar_custom.dart';
import 'package:reparaciones_moka/features/clientes/presentation/providers/cliente_provider.dart';

class ClientesPage extends ConsumerStatefulWidget {
  const ClientesPage({super.key});
  @override
  ConsumerState<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends ConsumerState<ClientesPage> {
  String query = "";
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(clientesProvider.notifier).loadClientes();
    });
  }

  List<Cliente> _filtrarClientes(List<Cliente> clientes) {
    if (query.isEmpty) return clientes;

    final q = query.toLowerCase();

    return clientes.where((c) {
      return c.nombre.toLowerCase().contains(q) ||
          c.telefono.toLowerCase().contains(q);
    }).toList();
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

    // Filtrar clientes según el query
    final clientesFiltrados = _filtrarClientes(state.clientes);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(clientesProvider.notifier).loadClientes();
      },
      child: Column(
        children: [
          // Barra de búsqueda
          SearchBarCustom(
            hintText: "cliente",
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
          ),

          // Lista de clientes filtrados
          Expanded(
            child: ListView.builder(
              itemCount: clientesFiltrados.length,
              itemBuilder: (context, index) {
                final cliente = state.clientes[index];
                final id = cliente.id.toString();

                return ListTile(
                  title: Text(
                    "${cliente.nombre} (ID: $id)",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text("Tel: ${cliente.telefono}"),
                  trailing: ElevatedButton.icon(
                    onPressed: () {
                      // launchUrl(Uri.parse("tel:$5{cliente.telefono}"));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F775A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    icon: const Icon(Icons.call),
                    label: const Text("Llamar"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
